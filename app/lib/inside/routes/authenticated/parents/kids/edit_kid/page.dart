import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../shared/models/kid.dart';
import '../../../../../blocs/auth/bloc.dart';
import '../../../../../blocs/kids/bloc.dart';
import '../../../../../blocs/kids/events.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../../util/breakpoints.dart';
import '../../../../widgets/scaffold.dart';

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
    return Routes_Scaffold(
      breakpointType: InsideUtil_BreakpointType.constrained,
      scaffold: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              child: const Icon(Icons.arrow_back),
              onPress: () {
                context.router.maybePop();
              },
            ),
          ],
          title: Text(
            widget.kid == null ? t.kids.addKidTitle : t.kids.editKidTitle,
          ),
          titleAlignment: Alignment.centerLeft,
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FTextField(
                        controller: _nameController,
                        label: Text(t.kids.name),
                        hint: t.kids.nameHint,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const Gap(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.kids.color,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(8),
                          InkWell(
                            onTap: _showColorPickerDialog,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _selectedColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                  Expanded(
                                    child: Text(
                                      _colorController.text.isEmpty
                                          ? t.kids.tapToSelectColor
                                          : _colorController.text.toUpperCase(),
                                      style: TextStyle(
                                        color: _colorController.text.isEmpty
                                            ? Colors.grey.shade600
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.color_lens,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(4),
                          Text(
                            t.kids.selectColorDescription,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const Gap(32),
                      FButton(onPress: _handleSubmit, child: Text(t.kids.save)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showColorPickerDialog() {
    showFDialog<void>(
      context: context,
      builder: (context, style, animation) {
        var tempColor = _selectedColor;
        return FDialog(
          style: style.call,
          animation: animation,
          direction: Axis.horizontal,
          title: Text(t.kids.pickColor),
          body: BlockPicker(
            pickerColor: _selectedColor,
            layoutBuilder: (context, colors, child) {
              return SizedBox(
                width: 300,
                height: 400,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: [for (final Color color in colors) child(color)],
                  ),
                ),
              );
            },
            onColorChanged: (Color color) {
              tempColor = color;
            },
          ),
          actions: [
            FButton(
              style: FButtonStyle.outline(),
              child: Text(t.kids.cancel),
              onPress: () => Navigator.of(context).pop(),
            ),
            FButton(
              child: Text(t.kids.select),
              onPress: () {
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
