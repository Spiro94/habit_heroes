import 'package:flutter/material.dart';

import '../../outside/theme/theme.dart';

/// A colorful selector component for picking options with visual feedback.
///
/// This component creates an interactive selector with a gradient accent color,
/// circular preview, and clear visual hierarchy. Ideal for color pickers,
/// option selectors, and other choice-based inputs.
///
/// Example:
/// ```dart
/// ColorfulSelector(
///   label: 'Color',
///   description: 'Pick a color for your profile',
///   selectedText: '#FF5733',
///   previewColor: Color(0xFFFF5733),
///   icon: Icons.color_lens,
///   gradient: context.colors.kidsManagementGreen,
///   onTap: () => showColorPicker(),
/// )
/// ```
class ColorfulSelector extends StatelessWidget {
  const ColorfulSelector({
    required this.label,
    required this.onTap,
    this.description,
    this.selectedText,
    this.previewColor,
    this.placeholderText,
    this.icon,
    this.gradient,
    super.key,
  });

  final String label;
  final String? description;
  final String? selectedText;
  final Color? previewColor;
  final String? placeholderText;
  final IconData? icon;
  final AppColorGradient? gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accentGradient =
        gradient ?? context.colors.datePickerCyan;
    final hasSelection = selectedText != null && selectedText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        // Selector card
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.solidColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.solidColors.border,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Preview (color circle or default icon)
                  if (previewColor != null)
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: previewColor,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: previewColor!.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: accentGradient.toLinearGradient(),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        icon ?? Icons.help_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  const SizedBox(width: 16),
                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasSelection
                              ? selectedText!
                              : placeholderText ?? 'Tap to select',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: hasSelection
                                ? context.solidColors.onSurface
                                : context.solidColors.onSurfaceVariant,
                          ),
                        ),
                        if (description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            description!,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.solidColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Trailing icon
                  Icon(
                    icon ?? Icons.arrow_forward_ios,
                    color: accentGradient.start,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
