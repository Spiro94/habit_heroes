import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../util/breakpoints.dart';
import '../../router.dart';
import '../../widgets/scaffold.dart';
import 'widgets/header.dart';

@RoutePage()
class Home_Page extends StatelessWidget implements AutoRouteWrapper {
  const Home_Page({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Routes_Scaffold(
      breakpointType: InsideUtil_BreakpointType.constrained,
      scaffold: FScaffold(
        header: const Home_Header(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => context.router.push(const ParentTasks_Routes()),
                child: FCard(
                  title: const Text('Tareas'),
                  subtitle: const Text(
                    'Gestiona las tareas de tus hijos aquí.',
                  ),
                  style: (style) {
                    return style.copyWith(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.router.push(const KidList_Route()),
                child: FCard(
                  title: const Text('Hijos'),
                  subtitle: const Text(
                    'Gestiona los perfiles de tus hijos aquí.',
                  ),
                  style: (style) {
                    return style.copyWith(
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
