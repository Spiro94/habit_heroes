import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/all.dart';

class Home_Widget_PinDialog extends StatefulWidget {
  const Home_Widget_PinDialog({super.key});

  @override
  State<Home_Widget_PinDialog> createState() => _Home_Widget_PinDialogState();
}

class _Home_Widget_PinDialogState extends State<Home_Widget_PinDialog> {
  final _pinController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _verifyPin() {
    if (_pinController.text == '1234') {
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        _errorMessage = 'PIN incorrecto. Intenta de nuevo.';
        _pinController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HabitHeroes_Dialog(
      title: 'Acceso Parental',
      dialogType: HabitHeroesDialogType.info,
      icon: Icons.lock_outline,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Ingresa el PIN de acceso parental',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            autofocus: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: '••••',
              counterText: '',
              filled: true,
              fillColor: context.solidColors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.colors.datePickerCyan.start,
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          if (_errorMessage.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: context.solidColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.solidColors.error.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: context.solidColors.error,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: context.solidColors.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        HabitHeroesDialogAction(
          label: 'Cancelar',
          onPressed: () => Navigator.of(context).pop(false),
        ),
        HabitHeroesDialogAction(
          label: 'Verificar',
          isPrimary: true,
          onPressed: _verifyPin,
        ),
      ],
    );
  }
}
