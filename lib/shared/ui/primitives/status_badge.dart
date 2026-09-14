import 'package:flutter/material.dart';
import '../app_palette.dart';
import '../tokens.dart';

enum BadgeTone { primary, success, warning, error, info, neutral }

/// Reusable pill status badge for indicators, tags, and states.
class StatusBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final BadgeTone tone;

  const StatusBadge({
    super.key,
    required this.label,
    this.icon,
    this.tone = BadgeTone.neutral,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final tintAlpha =
        Theme.of(context).brightness == Brightness.dark ? 0.25 : 0.12;

    Color tint(Color color) => color.withValues(alpha: tintAlpha);
    Color outline(Color color) => color.withValues(alpha: 0.3);

    final (Color bg, Color fg, Color border) = switch (tone) {
      BadgeTone.primary => (
          tint(AppTokens.primary),
          Theme.of(context).brightness == Brightness.dark
              ? palette.textPrimary
              : AppTokens.primary,
          outline(AppTokens.primary),
        ),
      BadgeTone.success => (
          tint(AppTokens.accentSuccess),
          palette.successFg,
          outline(AppTokens.accentSuccess),
        ),
      BadgeTone.warning => (
          tint(AppTokens.accentWarning),
          palette.warningFg,
          outline(AppTokens.accentWarning),
        ),
      BadgeTone.error => (
          tint(AppTokens.accentError),
          palette.errorFg,
          outline(AppTokens.accentError),
        ),
      BadgeTone.info => (
          tint(AppTokens.accentInfo),
          palette.infoFg,
          outline(AppTokens.accentInfo),
        ),
      BadgeTone.neutral => (
          palette.surface,
          palette.textSecondary,
          palette.border,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppTokens.radiusFull,
        border: Border.all(color: border, width: 1.0),
      ),
      // A single rich text (instead of a Row) truncates with an ellipsis when
      // the badge is width-constrained, yet still sizes naturally inside Rows.
      child: Text.rich(
        TextSpan(
          children: [
            if (icon != null)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(icon, size: 12, color: fg),
                ),
              ),
            TextSpan(text: label),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: -0.1,
        ),
      ),
    );
  }
}
