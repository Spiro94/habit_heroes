import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../outside/theme/theme.dart';
import '../../../../../../shared/widgets/all.dart';
import '../../../../../blocs/kids/bloc.dart';
import '../../../../../blocs/kids/events.dart';
import '../../../../../blocs/kids/state.dart';
import '../../../../../i18n/translations.g.dart';
import '../../../../router.dart';
import '../../../../widgets/colorful_card.dart';

@RoutePage()
class KidList_Page extends StatelessWidget {
  const KidList_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.kids.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.colors.kidsManagementGreen.start,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router.push(AddEditKid_Route()),
        backgroundColor: context.colors.kidsManagementGreen.start,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(
          t.kids.addKid,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<Kids_Bloc, Kids_State>(
        builder: (context, state) {
          if (state.status == Kids_Status.loading ||
              state.status == Kids_Status.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == Kids_Status.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: context.solidColors.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline,
                      size: 64,
                      color: context.solidColors.error,
                    ),
                  ),
                  const Gap(24),
                  Text(
                    'Error: ${state.errorMessage ?? t.kids.somethingWentWrong}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<Kids_Bloc>().add(
                        const Kids_Event_LoadKids(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.solidColors.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
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
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient:
                            context.colors.kidsManagementGreen
                                .toLinearGradient(),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.child_care,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(24),
                    Text(
                      t.kids.noKidsYet,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      t.kids.addFirstKid,
                      style: TextStyle(
                        color: context.solidColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
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

                // Use kid's color or fallback to kids management green
                final cardGradient =
                    kidColor != null
                        ? AppColorGradient(
                          start: kidColor,
                          end: kidColor.withValues(alpha: 0.8),
                        )
                        : context.colors.kidsManagementGreen;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ColorfulCard(
                    gradient: cardGradient,
                    borderRadius: 16,
                    shadowBlur: 12,
                    shadowOffset: const Offset(0, 4),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          // Avatar
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                            child:
                                kid.avatarUrl != null &&
                                        kid.avatarUrl!.isNotEmpty
                                    ? ClipOval(
                                      child: Image.network(
                                        kid.avatarUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                _buildInitialAvatar(kid.name),
                                      ),
                                    )
                                    : _buildInitialAvatar(kid.name),
                          ),
                          const Gap(16),
                          // Name
                          Expanded(
                            child: Text(
                              kid.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Gap(8),
                          // Action buttons
                          Material(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () {
                                context.router.push(AddEditKid_Route(kid: kid));
                              },
                              customBorder: const CircleBorder(),
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Material(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () {
                                _showDeleteDialog(context, kid.id, kid.name);
                              },
                              customBorder: const CircleBorder(),
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(child: Text(t.kids.somethingWentWrong));
        },
      ),
    );
  }

  Widget _buildInitialAvatar(String name) {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String kidId, String kidName) {
    final kidsBloc = context.read<Kids_Bloc>();
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => HabitHeroes_Dialog(
            title: t.kids.deleteKid,
            dialogType: HabitHeroesDialogType.error,
            icon: Icons.delete_outline,
            body: Text(t.kids.deleteKidConfirm(name: kidName)),
            actions: [
              HabitHeroesDialogAction(
                label: t.kids.cancel,
                onPressed: () => Navigator.of(context).pop(),
              ),
              HabitHeroesDialogAction(
                label: t.tasks.delete,
                isPrimary: true,
                onPressed: () {
                  kidsBloc.add(Kids_Event_DeleteKid(id: kidId));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }
}
