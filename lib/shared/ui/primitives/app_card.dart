import 'package:flutter/material.dart';
import '../app_palette.dart';
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
    final palette = AppPalette.of(context);

    final bg = backgroundColor ?? palette.card;
    final borderCol = borderColor ?? palette.border;
    final radius = borderRadius ?? AppTokens.radiusLg;

    final content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(AppTokens.spaceMd),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
        border: Border.all(color: borderCol, width: 1.0),
        boxShadow: palette.cardShadow,
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
