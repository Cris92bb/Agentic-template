import 'package:flutter/material.dart';
import '../tokens.dart';

enum AppButtonVariant { primary, secondary, ghost }

/// Standard reusable button adhering to design tokens and accessibility guidelines.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.width,
    this.height = 44.0,
  });

  const AppButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 44.0,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.ghost({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 44.0,
  }) : variant = AppButtonVariant.ghost;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bg;
    Color fg;
    Border? border;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = isDark ? AppTokens.darkActionBg : AppTokens.lightActionBg;
        fg = isDark ? AppTokens.darkActionFg : AppTokens.lightActionFg;
        border = null;
        break;
      case AppButtonVariant.secondary:
        bg = isDark ? AppTokens.darkSurfaceBg : AppTokens.lightSurfaceBg;
        fg = isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary;
        border = Border.all(
          color: isDark ? AppTokens.darkBorder : AppTokens.lightBorder,
          width: 1.0,
        );
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary;
        border = null;
        break;
    }

    final isClickable = onPressed != null && !isLoading;

    return Semantics(
      button: true,
      enabled: isClickable,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isClickable ? onPressed : null,
          borderRadius: AppTokens.radiusMd,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: AppTokens.spaceMd),
            decoration: BoxDecoration(
              color: isClickable ? bg : bg.withValues(alpha: 0.5),
              borderRadius: AppTokens.radiusMd,
              border: border,
            ),
            child: Row(
              mainAxisSize: width != null ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(fg),
                    ),
                  ),
                  const SizedBox(width: AppTokens.spaceSm),
                ] else if (icon != null) ...[
                  Icon(icon, size: 18, color: fg),
                  const SizedBox(width: AppTokens.spaceSm),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: fg,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
