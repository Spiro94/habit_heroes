import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:gap/gap.dart';

import '../../../../../blocs/kids/bloc.dart';
import '../../../../../blocs/kids/events.dart';
import '../../../../../blocs/kids/state.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../../util/breakpoints.dart';
import '../../../../router.dart';
import '../../../../widgets/scaffold.dart';

@RoutePage()
class KidList_Page extends StatelessWidget {
  const KidList_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Routes_Scaffold(
      breakpointType: InsideUtil_BreakpointType.constrained,
      scaffold: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              child: const Icon(Icons.arrow_back),
              onPress: () {
                context.router.maybePop();
              },
            ),
          ],
          title: Text(t.kids.title),
          titleAlignment: Alignment.centerLeft,
          suffixes: [
            FButton(
              child: Text(t.kids.addKid),
              onPress: () {
                context.router.push(AddEditKid_Route());
              },
            ),
          ],
        ),
        footer: FloatingActionButton(
          onPressed: () => context.router.push(AddEditKid_Route()),
          child: const Icon(Icons.add),
        ),
        child: BlocBuilder<Kids_Bloc, Kids_State>(
          builder: (context, state) {
            if (state.status == Kids_Status.loading ||
                state.status == Kids_Status.initial) {
              return const Center(child: FCircularProgress());
            }

            if (state.status == Kids_Status.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.errorMessage ?? t.kids.somethingWentWrong}',
                    ),
                    const Gap(16),
                    FButton(
                      onPress: () {
                        context.read<Kids_Bloc>().add(
                          const Kids_Event_LoadKids(),
                        );
                      },
                      child: Text(t.kids.tryAgain),
                    ),
                  ],
                ),
              );
            }

            if (state.status == Kids_Status.loaded) {
              if (state.kids.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(t.kids.noKidsYet),
                      const Gap(16),
                      FButton(
                        child: Text(t.kids.addFirstKid),
                        onPress: () {
                          context.router.push(AddEditKid_Route());
                        },
                      ),
                    ],
                  ),
                );
              }

              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: state.kids.length,
                  itemBuilder: (context, index) {
                    final kid = state.kids[index];
                    final hasColor = kid.color?.isNotEmpty ?? false;
                    Color? kidColor;

                    // Parse kid's color if available
                    if (hasColor) {
                      try {
                        final colorHex = kid.color!.replaceFirst('#', '');
                        kidColor = Color(
                          int.parse(colorHex, radix: 16) + 0xFF000000,
                        );
                      } catch (e) {
                        kidColor = null;
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FCard(
                        style: (style) {
                          return style.copyWith(
                            decoration: style.decoration.copyWith(
                              color:
                                  kidColor?.withAlpha(100) ??
                                  style.decoration.color,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: kidColor ?? Colors.grey.shade300,
                              backgroundImage:
                                  kid.avatarUrl != null &&
                                      kid.avatarUrl!.isNotEmpty
                                  ? NetworkImage(kid.avatarUrl!)
                                  : null,
                              child:
                                  kid.avatarUrl == null ||
                                      kid.avatarUrl!.isEmpty
                                  ? Text(
                                      kid.name.isNotEmpty
                                          ? kid.name[0].toUpperCase()
                                          : '?',
                                      style: TextStyle(
                                        color: kidColor != null
                                            ? _getContrastColor(kidColor)
                                            : Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    )
                                  : null,
                            ),
                            const Gap(16),
                            Expanded(
                              child: Text(
                                kid.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            FButton.icon(
                              style: FButtonStyle.primary(),
                              child: const Icon(Icons.edit),
                              onPress: () {
                                context.router.push(AddEditKid_Route(kid: kid));
                              },
                            ),
                            const Gap(8),
                            FButton.icon(
                              style: FButtonStyle.destructive(),
                              child: const Icon(Icons.delete),
                              onPress: () {
                                _showDeleteDialog(context, kid.id, kid.name);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return Center(child: Text(t.kids.somethingWentWrong));
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String kidId, String kidName) {
    final kidsBloc = context.read<Kids_Bloc>();
    showAdaptiveDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => FDialog(
        direction: Axis.horizontal,
        title: Text(t.kids.deleteKid),
        body: Text(t.kids.deleteKidConfirm(name: kidName)),
        actions: [
          FButton(
            style: FButtonStyle.outline(),
            child: Text(t.kids.cancel),
            onPress: () => Navigator.of(context).pop(),
          ),
          FButton(
            style: FButtonStyle.destructive(),
            child: Text(t.tasks.delete),
            onPress: () {
              kidsBloc.add(Kids_Event_DeleteKid(id: kidId));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    // Calculate the luminance of the background color
    final luminance = backgroundColor.computeLuminance();
    // Return white for dark backgrounds, black for light backgrounds
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }
}
