import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

@RoutePage(name: 'Settings_Routes')
class Settings_Router extends StatelessWidget {
  const Settings_Router({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Configuración',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const AutoRouter(),
    );
  }
}
