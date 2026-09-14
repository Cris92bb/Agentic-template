import 'package:flutter/material.dart';
import '../tokens.dart';

/// Reusable surface container applying token colors, borders, and ambient shadows.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = backgroundColor ??
        (isDark ? AppTokens.darkCardBg : AppTokens.lightCardBg);
    final borderCol =
        borderColor ?? (isDark ? AppTokens.darkBorder : AppTokens.lightBorder);
    final radius = borderRadius ?? AppTokens.radiusLg;
    final shadows =
        isDark ? AppTokens.darkCardShadow : AppTokens.lightCardShadow;

    final content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(AppTokens.spaceMd),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
        border: Border.all(color: borderCol, width: 1.0),
        boxShadow: shadows,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: content,
        ),
      );
    }

    return content;
  }
}
