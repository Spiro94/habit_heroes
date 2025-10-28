import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../outside/repositories/kids_dashboard/repository.dart';
import '../../../blocs/kids_dashboard/bloc.dart';
import 'page.dart';

@RoutePage(name: 'KidsDashboard_Route')
class KidsDashboard_Router extends StatelessWidget {
  const KidsDashboard_Router({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KidsDashboard_Bloc(
        kidsDashboardRepository: context.read<KidsDashboard_Repository>(),
      ),
      child: const KidsDashboard_Page(),
    );
  }
}
