import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/repositories/parent_access/repository.dart';
import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/widgets/all.dart';
import '../../../../blocs/parent_access/bloc.dart';
import '../../../../blocs/parent_access/events.dart';
import '../../../../blocs/parent_access/state.dart';

@RoutePage()
class ChangePincode_Page extends StatelessWidget {
  const ChangePincode_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentAccess_Bloc(
        parentAccessRepository: context.read<ParentAccess_Repository>(),
      ),
      child: const ChangePincode_Scaffold(),
    );
  }
}

class ChangePincode_Scaffold extends StatefulWidget {
  const ChangePincode_Scaffold({super.key});

  @override
  State<ChangePincode_Scaffold> createState() => _ChangePincode_ScaffoldState();
}

class _ChangePincode_ScaffoldState extends State<ChangePincode_Scaffold> {
  final _currentPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final bloc = context.read<ParentAccess_Bloc>();
    bloc.add(
      ParentAccess_Event_UpdatePin(
        currentPin: _currentPinController.text,
        newPin: _newPinController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Cambiar PIN Parental',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<ParentAccess_Bloc, ParentAccess_State>(
        listener: (context, state) {
          if (state.status == ParentAccess_Status.updateSuccess) {
            showDialog<void>(
              context: context,
              builder: (dialogContext) => HabitHeroes_Dialog(
                title: 'PIN Actualizado',
                dialogType: HabitHeroesDialogType.success,
                icon: Icons.check_circle_outline,
                body: const Text(
                  'Tu PIN parental ha sido actualizado exitosamente.',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  HabitHeroesDialogAction(
                    label: 'Aceptar',
                    isPrimary: true,
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      context.router.maybePop();
                    },
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          final pinsDoNotMatch =
              _newPinController.text.isNotEmpty &&
              _confirmPinController.text.isNotEmpty &&
              _newPinController.text != _confirmPinController.text;

          final hasError = state.status == ParentAccess_Status.updateError;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Ingresa tu PIN actual y luego el nuevo PIN que deseas '
                      'configurar.',
                      style: TextStyle(
                        fontSize: 16,
                        color: context.solidColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'PIN Actual',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.solidColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _currentPinController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 4,
                      textAlign: TextAlign.center,
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Nuevo PIN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.solidColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _newPinController,
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Confirmar Nuevo PIN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.solidColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                    if (pinsDoNotMatch) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.solidColors.error.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.solidColors.error.withValues(
                              alpha: 0.3,
                            ),
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
                    if (hasError && state.errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.solidColors.error.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.solidColors.error.withValues(
                              alpha: 0.3,
                            ),
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
                                state.errorMessage!,
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
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed:
                          pinsDoNotMatch ||
                              _currentPinController.text.length != 4 ||
                              _newPinController.text.length != 4 ||
                              _confirmPinController.text.length != 4 ||
                              state.status == ParentAccess_Status.updating
                          ? null
                          : _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: context.colors.datePickerCyan.start,
                        foregroundColor: Colors.white,
                      ),
                      child: state.status == ParentAccess_Status.updating
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Actualizar PIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
