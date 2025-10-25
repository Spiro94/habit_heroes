import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ParentDashboard_Page extends StatelessWidget {
  const ParentDashboard_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Dashboard')),
      body: const Center(child: Text('Welcome to the Parent Dashboard!')),
    );
  }
}
