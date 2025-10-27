import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../outside/repositories/kids/repository.dart';
import '../../../../blocs/kids/bloc.dart';
import '../../../../blocs/kids/events.dart';

@RoutePage(name: 'ParentKids_Routes')
class ParentKids_Router extends StatelessWidget {
  const ParentKids_Router({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          Kids_Bloc(context.read<Kids_Repository>())
            ..add(const Kids_Event_LoadKids()),
      child: const AutoRouter(),
    );
  }
}
