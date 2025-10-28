import 'package:flutter/material.dart';

import '../../../outside/theme/theme.dart';

/// A reusable card widget with gradient background and shadow
class ColorfulCard extends StatelessWidget {
  const ColorfulCard({
    required this.gradient,
    required this.child,
    this.onTap,
    this.height,
    this.borderRadius = 24.0,
    this.shadowOpacity = 0.3,
    this.shadowBlur = 20.0,
    this.shadowOffset = const Offset(0, 10),
    super.key,
  });

  /// The gradient to apply to the card
  final AppColorGradient gradient;

  /// The child widget to display inside the card
  final Widget child;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Optional height of the card
  final double? height;

  /// Border radius of the card corners
  final double borderRadius;

  /// Opacity of the shadow color
  final double shadowOpacity;

  /// Blur radius of the shadow
  final double shadowBlur;

  /// Offset of the shadow
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    final shadowColor = gradient.toShadowColor(shadowOpacity);

    final card = Container(
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
      child: child,
    );

    if (onTap == null) {
      return card;
    }

    return GestureDetector(
      onTap: onTap,
      child: card,
    );
  }
}
