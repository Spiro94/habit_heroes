import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/all.dart';
import '../../../../blocs/parent_access/bloc.dart';
import '../../../../blocs/parent_access/events.dart';
import '../../../../blocs/parent_access/state.dart';

enum PinDialogMode { create, verify }

class Home_Widget_PinDialog extends StatefulWidget {
  const Home_Widget_PinDialog({super.key});

  @override
  State<Home_Widget_PinDialog> createState() => _Home_Widget_PinDialogState();
}

class _Home_Widget_PinDialogState extends State<Home_Widget_PinDialog> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool isCreateMode = false;

  @override
  void initState() {
    context.read<ParentAccess_Bloc>().add(ParentAccess_Event_CheckPinExists());
    super.initState();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final bloc = context.read<ParentAccess_Bloc>();

    if (isCreateMode) {
      if (_pinController.text != _confirmPinController.text) {
        return;
      }
      bloc.add(ParentAccess_Event_CreatePin(pin: _pinController.text));
    } else {
      bloc.add(ParentAccess_Event_VerifyPin(pin: _pinController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParentAccess_Bloc, ParentAccess_State>(
      listener: (context, state) {
        if (state.status == ParentAccess_Status.checked) {
          isCreateMode = !(state.pinExists ?? false);
        }
        if (isCreateMode) {
          if (state.status == ParentAccess_Status.createSuccess) {
            Navigator.of(context).pop(true);
          }
        } else {
          if (state.status == ParentAccess_Status.verifySuccess) {
            Navigator.of(context).pop(true);
          } else if (state.status == ParentAccess_Status.verifyError) {
            _pinController.clear();
          }
        }
      },
      builder: (context, state) {
        final errorMessage = state.errorMessage;

        final hasError = isCreateMode
            ? state.status == ParentAccess_Status.createError
            : state.status == ParentAccess_Status.verifyError;

        final pinsDoNotMatch =
            isCreateMode &&
            _pinController.text.isNotEmpty &&
            _confirmPinController.text.isNotEmpty &&
            _pinController.text != _confirmPinController.text;

        return HabitHeroes_Dialog(
          title: isCreateMode ? 'Crear PIN Parental' : 'Acceso Parental',
          dialogType: HabitHeroesDialogType.info,
          icon: Icons.lock_outline,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isCreateMode
                    ? 'Crea un PIN de 4 dígitos para el acceso parental'
                    : 'Ingresa el PIN de acceso parental',
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
                onChanged: (_) {
                  if (isCreateMode) {
                    setState(() {});
                  }
                },
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              if (isCreateMode) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: '••••',
                    labelText: 'Confirmar PIN',
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
              ],
              if (pinsDoNotMatch) ...[
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
                          'Los PINs no coinciden',
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
              if (hasError && errorMessage != null) ...[
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
                          errorMessage,
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
              label: isCreateMode ? 'Crear' : 'Verificar',
              isPrimary: true,
              onPressed: () {
                if (isCreateMode && pinsDoNotMatch) {
                  return;
                }
                _handleSubmit();
              },
            ),
          ],
        );
      },
    );
  }
}
