import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/models/kid.dart';
import '../../../../../../shared/widgets/all.dart';
import '../../../../../blocs/auth/bloc.dart';
import '../../../../../blocs/kids/bloc.dart';
import '../../../../../blocs/kids/events.dart';
import '../../../../../i18n/translations.g.dart';

@RoutePage()
class AddEditKid_Page extends StatefulWidget {
  final Kid? kid;

  const AddEditKid_Page({super.key, this.kid});

  @override
  State<AddEditKid_Page> createState() => _AddEditKid_PageState();
}

class _AddEditKid_PageState extends State<AddEditKid_Page> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _colorController;
  Color _selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.kid?.name ?? '');
    final colorHex = widget.kid?.color ?? '';
    _colorController = TextEditingController(text: colorHex);

    // Parse existing color if available
    if (colorHex.isNotEmpty) {
      try {
        _selectedColor = Color(
          int.parse(colorHex.replaceFirst('#', ''), radix: 16) + 0xFF000000,
        );
      } catch (e) {
        _selectedColor = Colors.blue;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.kid == null ? t.kids.addKidTitle : t.kids.editKidTitle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.colors.kidsManagementGreen.start,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Name field
            ColorfulTextField(
              label: t.kids.name,
              hint: t.kids.nameHint,
              controller: _nameController,
              gradient: context.colors.kidsManagementGreen,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            const Gap(24),
            // Color picker section
            ColorfulSelector(
              label: t.kids.color,
              description: t.kids.selectColorDescription,
              selectedText: _colorController.text.isEmpty
                  ? null
                  : _colorController.text.toUpperCase(),
              previewColor: _colorController.text.isEmpty
                  ? null
                  : _selectedColor,
              placeholderText: t.kids.tapToSelectColor,
              icon: Icons.color_lens,
              gradient: context.colors.kidsManagementGreen,
              onTap: _showColorPickerDialog,
            ),
            const Gap(32),
            // Save button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.kidsManagementGreen.start,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  t.kids.save,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPickerDialog() {
    var tempColor = _selectedColor;
    showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return HabitHeroes_Dialog(
              title: t.kids.pickColor,
              dialogType: HabitHeroesDialogType.info,
              icon: Icons.palette,
              body: BlockPicker(
                pickerColor: tempColor,
                layoutBuilder: (context, colors, child) {
                  return SizedBox(
                    width: 300,
                    height: 360,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      padding: const EdgeInsets.all(8),
                      children: [
                        for (final Color color in colors) child(color),
                      ],
                    ),
                  );
                },
                onColorChanged: (Color color) {
                  setDialogState(() {
                    tempColor = color;
                  });
                },
              ),
              actions: [
                HabitHeroesDialogAction(
                  label: t.kids.cancel,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                HabitHeroesDialogAction(
                  label: t.kids.select,
                  isPrimary: true,
                  onPressed: () {
                    setState(() {
                      _selectedColor = tempColor;
                      _colorController.text = _colorToHex(tempColor);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  }

  void _handleSubmit() {
    if (_nameController.text.isEmpty) {
      _showError(t.kids.pleaseEnterName);
      return;
    }

    final parentId = context.read<Auth_Bloc>().state.appUser!.id;
    final kid = Kid(
      id: widget.kid?.id ?? const Uuid().v4(),
      parentId: parentId,
      name: _nameController.text,
      color: _colorController.text.isEmpty ? null : _colorController.text,
    );

    if (widget.kid == null) {
      context.read<Kids_Bloc>().add(Kids_Event_AddKid(kid: kid));
    } else {
      context.read<Kids_Bloc>().add(Kids_Event_UpdateKid(kid: kid));
    }

    context.router.maybePop();
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => HabitHeroes_Dialog(
        title: t.kids.somethingWentWrong,
        dialogType: HabitHeroesDialogType.error,
        icon: Icons.error_outline,
        body: Text(message),
        actions: [
          HabitHeroesDialogAction(
            label: t.kids.cancel,
            isPrimary: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
