import 'dart:io';

/// Feature-Sliced Design (FSD v2.1) Architecture Validator for Agentic Template.
///
/// Scans the `import` and `export` directives of every Dart file in `lib/`
/// (a line-based scan, not a full AST parse) and reports:
/// - upward layer imports (e.g. `shared` importing `features`),
/// - cross-slice imports inside `pages`, `widgets`, `features` and `entities`,
/// - deep imports that bypass a slice's public barrel (`<slice>/<slice>.dart`).
///
/// Usage:
///   dart run tool/verify_fsd.dart [--strict]
///
/// Violations are always printed; with `--strict` they also exit with code 1.

const Map<String, int> layerHierarchy = {
  'app': 1,
  'pages': 2,
  'widgets': 3,
  'features': 4,
  'entities': 5,
  'shared': 6,
};

/// Layers organized into segments (`ui`, `lib`, `theme`, ...) instead of
/// slices, so imports between their sub-folders are not cross-slice couplings.
/// Their public API is the layer barrel (`lib/<layer>/<layer>.dart`).
const Set<String> segmentedLayers = {'app', 'shared'};

class FsdViolation {
  final String file;
  final int line;
  final String importUri;
  final String sourceLayer;
  final String? sourceSlice;
  final String targetLayer;
  final String? targetSlice;
  final String violationType;
  final String description;

  const FsdViolation({
    required this.file,
    required this.line,
    required this.importUri,
    required this.sourceLayer,
    required this.sourceSlice,
    required this.targetLayer,
    required this.targetSlice,
    required this.violationType,
    required this.description,
  });

  @override
  String toString() {
    return '[$violationType] $file:$line\n'
        '  Source: $sourceLayer${sourceSlice != null ? '/$sourceSlice' : ''}\n'
        '  Target: $targetLayer${targetSlice != null ? '/$targetSlice' : ''} ($importUri)\n'
        '  Reason: $description';
  }
}

class FsdAuditResult {
  final List<FsdViolation> upwardViolations;
  final List<FsdViolation> crossSliceViolations;
  final List<FsdViolation> barrelViolations;
  final int totalScannedFiles;
  final int totalScannedImports;

  const FsdAuditResult({
    required this.upwardViolations,
    required this.crossSliceViolations,
    required this.barrelViolations,
    required this.totalScannedFiles,
    required this.totalScannedImports,
  });

  int get totalViolations =>
      upwardViolations.length +
      crossSliceViolations.length +
      barrelViolations.length;
}

final RegExp _directiveRegex =
    RegExp(r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''');

FsdAuditResult auditDirectory(Directory libDir) {
  final upwardViolations = <FsdViolation>[];
  final crossSliceViolations = <FsdViolation>[];
  final barrelViolations = <FsdViolation>[];

  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  int totalImports = 0;

  for (final file in dartFiles) {
    final relSourcePath = file.path.replaceAll(r'\', '/');
    final (sourceLayer, sourceSlice) = _parseLayerAndSlice(relSourcePath);
    if (sourceLayer == null || !layerHierarchy.containsKey(sourceLayer)) {
      continue;
    }

    final lines = file.readAsLinesSync();
    for (int i = 0; i < lines.length; i++) {
      final match = _directiveRegex.firstMatch(lines[i]);
      if (match == null) continue;

      totalImports++;
      final importUri = match.group(1)!;
      final targetResolvedPath = _resolveImport(file, importUri);
      if (targetResolvedPath == null) continue;

      final (targetLayer, targetSlice) =
          _parseLayerAndSlice(targetResolvedPath);
      if (targetLayer == null || !layerHierarchy.containsKey(targetLayer)) {
        continue;
      }

      FsdViolation violation(String type, String description) => FsdViolation(
            file: relSourcePath,
            line: i + 1,
            importUri: importUri,
            sourceLayer: sourceLayer,
            sourceSlice: sourceSlice,
            targetLayer: targetLayer,
            targetSlice: targetSlice,
            violationType: type,
            description: description,
          );

      final sourceRank = layerHierarchy[sourceLayer]!;
      final targetRank = layerHierarchy[targetLayer]!;
      final isSegmented = segmentedLayers.contains(targetLayer);
      final isSameUnit = sourceLayer == targetLayer &&
          (isSegmented || (sourceSlice != null && sourceSlice == targetSlice));

      // 1. Upward Layer Violation (Lower layer importing higher layer)
      // Note: lower in hierarchy has higher rank number (shared=6, app=1).
      if (sourceRank > targetRank) {
        upwardViolations.add(violation(
          'UPWARD_LAYER_INVERSION',
          'Layer "$sourceLayer" cannot import from higher layer "$targetLayer".',
        ));
      }
      // 2. Cross-Slice Isolation Violation (Same layer, different slices)
      else if (sourceLayer == targetLayer &&
          !isSegmented &&
          sourceSlice != null &&
          targetSlice != null &&
          sourceSlice != targetSlice) {
        crossSliceViolations.add(violation(
          'CROSS_SLICE_COUPLING',
          'Slice "$sourceSlice" cannot import from sibling slice "$targetSlice" within the same layer "$sourceLayer".',
        ));
      }
      // 3. Public API Violation (deep import from outside the slice/segment)
      else if (!isSameUnit &&
          !_isPublicApi(targetResolvedPath, targetLayer, targetSlice)) {
        final barrel = isSegmented
            ? '$targetLayer/$targetLayer.dart'
            : '$targetLayer/$targetSlice/$targetSlice.dart';
        barrelViolations.add(violation(
          'DEEP_IMPORT',
          'Import through the public barrel "$barrel" instead.',
        ));
      }
    }
  }

  return FsdAuditResult(
    upwardViolations: upwardViolations,
    crossSliceViolations: crossSliceViolations,
    barrelViolations: barrelViolations,
    totalScannedFiles: dartFiles.length,
    totalScannedImports: totalImports,
  );
}

(String?, String?) _parseLayerAndSlice(String path) {
  final normalized = path.replaceAll(r'\', '/');
  final parts = normalized.split('/');
  final libIndex = parts.indexOf('lib');
  if (libIndex == -1 || libIndex + 1 >= parts.length) {
    return (null, null);
  }

  final layer = parts[libIndex + 1];
  String? slice;
  if (libIndex + 2 < parts.length && !parts[libIndex + 2].endsWith('.dart')) {
    slice = parts[libIndex + 2];
  }
  return (layer, slice);
}

bool _isPublicApi(String path, String layer, String? slice) {
  final normalized = path.replaceAll(r'\', '/');
  final barrel = segmentedLayers.contains(layer)
      ? 'lib/$layer/$layer.dart'
      : 'lib/$layer/$slice/$slice.dart';
  return normalized == barrel || normalized.endsWith('/$barrel');
}

String? _resolveImport(File sourceFile, String uri) {
  if (uri.startsWith('dart:')) return null;
  if (uri.startsWith('package:')) {
    if (!uri.startsWith('package:agentic_template/')) return null;
    return 'lib/${uri.substring('package:agentic_template/'.length)}';
  }

  // Relative import
  final sourceDir = sourceFile.parent;
  final targetFile = File('${sourceDir.path}/$uri');
  final normalized = targetFile.uri.normalizePath().toFilePath();
  final projectRoot = Directory.current.path;
  if (normalized.startsWith(projectRoot)) {
    return normalized.substring(projectRoot.length + 1).replaceAll(r'\', '/');
  }
  return normalized.replaceAll(r'\', '/');
}

void main(List<String> args) {
  final strict = args.contains('--strict');
  final libDir = Directory('lib');

  if (!libDir.existsSync()) {
    stderr.writeln('Error: lib/ directory not found in ${Directory.current.path}');
    exit(1);
  }

  stdout.writeln('🔍 Running Feature-Sliced Design (FSD v2.1) Architectural Audit...');
  final result = auditDirectory(libDir);

  stdout.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  stdout.writeln('Total Dart files scanned:   ${result.totalScannedFiles}');
  stdout.writeln('Total directives inspected: ${result.totalScannedImports}');
  stdout.writeln('Upward Layer Inversions:    ${result.upwardViolations.length}');
  stdout.writeln('Cross-Slice Couplings:      ${result.crossSliceViolations.length}');
  stdout.writeln('Deep (non-barrel) Imports:  ${result.barrelViolations.length}');
  stdout.writeln('Total Architectural Breaches: ${result.totalViolations}');
  stdout.writeln('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  void printSection(String title, List<FsdViolation> violations) {
    if (violations.isEmpty) return;
    stdout.writeln(title);
    for (final v in violations) {
      stdout.writeln(v);
      stdout.writeln();
    }
  }

  printSection('🚨 UPWARD LAYER INVERSIONS (Critical Severity):', result.upwardViolations);
  printSection('⚠️ CROSS-SLICE COUPLINGS (High Severity):', result.crossSliceViolations);
  printSection('⚠️ DEEP IMPORTS BYPASSING PUBLIC BARRELS (High Severity):', result.barrelViolations);

  if (result.totalViolations > 0) {
    if (strict) {
      stderr.writeln('❌ Strict Mode Failed: Found ${result.totalViolations} architectural violations.');
      exit(1);
    }
    stdout.writeln('⚠️ Found ${result.totalViolations} architectural violations. Run with --strict to fail the build.');
    return;
  }
  stdout.writeln('✅ Zero architectural violations detected.');
}
