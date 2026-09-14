import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Reuse the CLI auditor so the test and `dart run tool/verify_fsd.dart` can
// never disagree about the rules.
import '../../tool/verify_fsd.dart'
    show FsdAuditResult, FsdViolation, auditDirectory;

String _describe(List<FsdViolation> violations) => violations.join('\n\n');

void main() {
  group('Feature-Sliced Design (FSD v2.1) Architecture Boundary Audit', () {
    late FsdAuditResult result;

    setUpAll(() {
      final libDir = Directory('lib');
      expect(libDir.existsSync(), isTrue, reason: 'lib/ directory must exist');
      result = auditDirectory(libDir);
    });

    test('scans the lib/ sources', () {
      expect(result.totalScannedFiles, greaterThan(0));
    });

    test('has no upward layer inversions', () {
      expect(
        result.upwardViolations,
        isEmpty,
        reason: _describe(result.upwardViolations),
      );
    });

    test('has no cross-slice couplings', () {
      expect(
        result.crossSliceViolations,
        isEmpty,
        reason: _describe(result.crossSliceViolations),
      );
    });

    test('imports slices only through their public barrels', () {
      expect(
        result.barrelViolations,
        isEmpty,
        reason: _describe(result.barrelViolations),
      );
    });
  });

  group('FSD auditor rules', () {
    late Directory root;

    void writeFile(String path, String contents) {
      File('${root.path}/$path')
        ..createSync(recursive: true)
        ..writeAsStringSync(contents);
    }

    setUp(() {
      root = Directory.systemTemp.createTempSync('fsd_audit_');
    });

    tearDown(() {
      root.deleteSync(recursive: true);
    });

    test('flags upward, cross-slice and deep imports', () {
      writeFile('lib/shared/shared.dart', "export 'ui/tokens.dart';\n");
      // Segments of a segmented layer may import each other.
      writeFile('lib/shared/ui/tokens.dart', "import '../lib/helpers.dart';\n");
      writeFile('lib/shared/lib/helpers.dart', '');
      writeFile(
        'lib/shared/lib/bad.dart',
        "import 'package:agentic_template/features/a/a.dart';\n",
      );
      writeFile('lib/features/a/a.dart', "export 'ui/a_widget.dart';\n");
      writeFile(
        'lib/features/a/ui/a_widget.dart',
        "import '../../../shared/shared.dart';\n"
            "import '../../b/b.dart';\n",
      );
      writeFile('lib/features/b/b.dart', '');
      writeFile(
        'lib/pages/home/home.dart',
        "import '../../features/a/ui/a_widget.dart';\n",
      );

      final result = auditDirectory(Directory('${root.path}/lib'));

      expect(result.upwardViolations.map((v) => v.importUri), [
        'package:agentic_template/features/a/a.dart',
      ]);
      expect(result.crossSliceViolations.map((v) => v.importUri), [
        '../../b/b.dart',
      ]);
      expect(result.barrelViolations.map((v) => v.importUri), [
        '../../features/a/ui/a_widget.dart',
      ]);
    });
  });
}
