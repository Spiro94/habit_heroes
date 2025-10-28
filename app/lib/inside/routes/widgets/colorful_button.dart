import 'package:flutter/material.dart';

import '../../../outside/theme/theme.dart';

/// A reusable button widget with gradient background
class ColorfulButton extends StatelessWidget {
  const ColorfulButton({
    required this.gradient,
    required this.label,
    required this.onPressed,
    this.icon,
    this.subtitle,
    this.height = 200,
    this.borderRadius = 24.0,
    this.shadowOpacity = 0.3,
    this.shadowBlur = 20.0,
    this.shadowOffset = const Offset(0, 10),
    this.iconSize = 80.0,
    this.labelFontSize = 36.0,
    this.subtitleFontSize = 16.0,
    super.key,
  });

  /// The gradient to apply to the button
  final AppColorGradient gradient;

  /// The main label text
  final String label;

  /// The callback when the button is pressed
  final VoidCallback onPressed;

  /// Optional icon to display above the label
  final IconData? icon;

  /// Optional subtitle text below the label
  final String? subtitle;

  /// Height of the button
  final double height;

  /// Border radius of the button corners
  final double borderRadius;

  /// Opacity of the shadow color
  final double shadowOpacity;

  /// Blur radius of the shadow
  final double shadowBlur;

  /// Offset of the shadow
  final Offset shadowOffset;

  /// Size of the icon
  final double iconSize;

  /// Font size of the label
  final double labelFontSize;

  /// Font size of the subtitle
  final double subtitleFontSize;

  @override
  Widget build(BuildContext context) {
    final shadowColor = gradient.toShadowColor(shadowOpacity);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient.toLinearGradient(),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: shadowBlur,
              offset: shadowOffset,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: iconSize,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
