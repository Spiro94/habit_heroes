import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

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
    return FDialog(
      title: const Text('Acceso Parental'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Ingresa el PIN de acceso parental',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          FTextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            hint: '1234',
            autofocus: true,
          ),
          if (_errorMessage.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
      actions: [
        FButton(
          onPress: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        FButton(
          onPress: _verifyPin,
          child: const Text('Verificar'),
        ),
      ],
    );
  }
}
