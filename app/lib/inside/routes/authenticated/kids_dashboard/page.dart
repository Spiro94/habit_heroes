import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/rewards_tab_widget.dart';
import 'widgets/tasks_tab_widget.dart';

@RoutePage()
class KidsDashboard_Page extends StatefulWidget {
  const KidsDashboard_Page({super.key});

  @override
  State<KidsDashboard_Page> createState() => _KidsDashboard_PageState();
}

class _KidsDashboard_PageState extends State<KidsDashboard_Page> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '¡Hola, Héroes!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFEC4899),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.router.popUntilRoot(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 0
                                ? const Color(0xFFEC4899)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            color: _selectedTab == 0
                                ? const Color(0xFFEC4899)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Mis Tareas',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _selectedTab == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectedTab == 0
                                  ? const Color(0xFFEC4899)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedTab == 1
                                ? const Color(0xFFEC4899)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.stars,
                            color: _selectedTab == 1
                                ? const Color(0xFFEC4899)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Recompensas',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _selectedTab == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _selectedTab == 1
                                  ? const Color(0xFFEC4899)
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _selectedTab == 0
          ? const KidsDashboard_Widget_TasksTab()
          : const KidsDashboard_Widget_RewardsTab(),
    );
  }
}
