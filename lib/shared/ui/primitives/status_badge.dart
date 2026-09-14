import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bg;
    Color fg;
    Color border;

    switch (tone) {
      case BadgeTone.primary:
        bg = AppTokens.primary.withValues(alpha: isDark ? 0.25 : 0.12);
        fg = isDark ? AppTokens.darkTextPrimary : AppTokens.primary;
        border = AppTokens.primary.withValues(alpha: 0.3);
        break;
      case BadgeTone.success:
        bg = AppTokens.accentSuccess.withValues(alpha: isDark ? 0.25 : 0.12);
        fg = isDark ? const Color(0xFF81C784) : AppTokens.accentSuccess;
        border = AppTokens.accentSuccess.withValues(alpha: 0.3);
        break;
      case BadgeTone.warning:
        bg = AppTokens.accentWarning.withValues(alpha: isDark ? 0.25 : 0.12);
        fg = isDark ? const Color(0xFFFFB74D) : AppTokens.accentWarning;
        border = AppTokens.accentWarning.withValues(alpha: 0.3);
        break;
      case BadgeTone.error:
        bg = AppTokens.accentError.withValues(alpha: isDark ? 0.25 : 0.12);
        fg = isDark ? const Color(0xFFE57373) : AppTokens.accentError;
        border = AppTokens.accentError.withValues(alpha: 0.3);
        break;
      case BadgeTone.info:
        bg = AppTokens.accentInfo.withValues(alpha: isDark ? 0.25 : 0.12);
        fg = isDark ? const Color(0xFF64B5F6) : AppTokens.accentInfo;
        border = AppTokens.accentInfo.withValues(alpha: 0.3);
        break;
      case BadgeTone.neutral:
        bg = isDark ? AppTokens.darkSurfaceBg : AppTokens.lightSurfaceBg;
        fg = isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary;
        border = isDark ? AppTokens.darkBorder : AppTokens.lightBorder;
        break;
    }

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
