import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../outside/theme/theme.dart';

/// A colorful text field with gradient focus border and enhanced visual feedback.
///
/// This component provides a more vibrant alternative to standard TextFields,
/// featuring gradient-colored focus borders and subtle hover effects.
///
/// Example:
/// ```dart
/// ColorfulTextField(
///   label: 'Name',
///   hint: 'Enter your name',
///   controller: nameController,
///   gradient: context.colors.kidsManagementGreen,
/// )
/// ```
class ColorfulTextField extends StatefulWidget {
  const ColorfulTextField({
    required this.label,
    this.hint,
    this.controller,
    this.gradient,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    super.key,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final AppColorGradient? gradient;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool autofocus;

  @override
  State<ColorfulTextField> createState() => _ColorfulTextFieldState();
}

class _ColorfulTextFieldState extends State<ColorfulTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient =
        widget.gradient ?? context.colors.datePickerCyan;
    final focusColor = gradient.start;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _isFocused
                ? focusColor
                : context.solidColors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        // Text field with gradient border when focused
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: _isFocused
                ? LinearGradient(
                    colors: [
                      gradient.start.withValues(alpha: 0.1),
                      gradient.end.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            onChanged: widget.onChanged,
            autofocus: widget.autofocus,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: context.solidColors.surfaceVariant,
              counterText: widget.maxLength != null ? null : '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: focusColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.solidColors.error,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.solidColors.error,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
