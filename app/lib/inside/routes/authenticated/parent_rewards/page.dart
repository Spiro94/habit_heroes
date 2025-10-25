import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ParentRewards_Page extends StatelessWidget {
  const ParentRewards_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Rewards')),
      body: const Center(child: Text('List of rewards for parents')),
    );
  }
}
