import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/app_settings/app_settings.dart';
import '../pages/home/home.dart';
import '../shared/shared.dart';
import 'theme/app_scroll_behavior.dart';
import 'theme/app_theme.dart';

/// Root application widget for Agentic Template.
///
/// Must be placed under a [ProviderScope]; `main.dart` creates it together with
/// the persistent storage override.
class AgenticApp extends ConsumerStatefulWidget {
  const AgenticApp({super.key});

  @override
  ConsumerState<AgenticApp> createState() => _AgenticAppState();
}

class _AgenticAppState extends ConsumerState<AgenticApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncTheme();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (ref.read(themeModeProvider) == ThemeMode.system) {
      _syncTheme();
    }
  }

  bool _computeIsDark(ThemeMode? mode) {
    if (mode == ThemeMode.dark) return true;
    if (mode == ThemeMode.light) return false;
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  void _syncTheme([ThemeMode? mode]) {
    final activeMode = mode ?? ref.read(themeModeProvider);
    final isDark = _computeIsDark(activeMode);
    PlatformThemeService.syncTheme(isDark: isDark);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    ref.listen<ThemeMode>(themeModeProvider, (_, next) {
      _syncTheme(next);
    });

    return MaterialApp(
      title: 'Agentic Template',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
