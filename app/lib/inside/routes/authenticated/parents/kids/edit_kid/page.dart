import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/models/kid.dart';
import '../../../../../blocs/auth/bloc.dart';
import '../../../../../blocs/kids/bloc.dart';
import '../../../../../blocs/kids/events.dart';

@RoutePage()
class AddEditKid_Page extends StatefulWidget {
  final Kid? kid;

  const AddEditKid_Page({Key? key, this.kid}) : super(key: key);

  @override
  _AddEditKid_PageState createState() => _AddEditKid_PageState();
}

class _AddEditKid_PageState extends State<AddEditKid_Page> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _color;

  @override
  void initState() {
    super.initState();
    _name = widget.kid?.name ?? '';
    _color = widget.kid?.color ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.kid == null ? 'Add Kid' : 'Edit Kid')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _color,
                decoration: const InputDecoration(labelText: 'Color'),
                onSaved: (value) => _color = value!,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final parentId = context
                        .read<Auth_Bloc>()
                        .state
                        .appUser!
                        .id;
                    final kid = Kid(
                      id: widget.kid?.id ?? DateTime.now().toIso8601String(),
                      parentId: parentId,
                      name: _name,
                      color: _color,
                    );
                    if (widget.kid == null) {
                      context.read<Kids_Bloc>().add(
                        Kids_Event_AddKid(kid: kid),
                      );
                    } else {
                      context.read<Kids_Bloc>().add(
                        Kids_Event_UpdateKid(kid: kid),
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
