import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ParentTasks_Page extends StatelessWidget {
  const ParentTasks_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Tasks')),
      body: const Center(child: Text('List of tasks for parents')),
    );
  }
}
