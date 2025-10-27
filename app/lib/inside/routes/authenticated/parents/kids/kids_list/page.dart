import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/kids/bloc.dart';
import '../../../../../blocs/kids/events.dart';
import '../../../../../blocs/kids/state.dart';
import '../../../../router.dart';

@RoutePage()
class KidList_Page extends StatelessWidget {
  const KidList_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kids')),
      body: BlocBuilder<Kids_Bloc, Kids_State>(
        builder: (context, state) {
          if (state.status == Kids_Status.loading ||
              state.status == Kids_Status.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == Kids_Status.loaded) {
            return ListView.builder(
              itemCount: state.kids.length,
              itemBuilder: (context, index) {
                final kid = state.kids[index];
                return ListTile(
                  title: Text(kid.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // context.router.push(AddEditKid_Route(kid: kid));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<Kids_Bloc>().add(
                            Kids_Event_DeleteKid(id: kid.id),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }

          if (state.status == Kids_Status.error) {
            return Center(child: Text(state.errorMessage ?? 'Error'));
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(AddEditKid_Route());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
