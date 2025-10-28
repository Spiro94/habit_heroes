import 'package:flutter/material.dart';

import '../../../../../outside/theme/theme.dart';
import '../../../../../shared/models/kid_points.dart';
import '../../../../../shared/models/reward.dart';
import '../../../../../shared/widgets/all.dart';

class KidsDashboard_Widget_KidSelectionDialog extends StatelessWidget {
  const KidsDashboard_Widget_KidSelectionDialog({
    required this.kids,
    required this.reward,
    required this.onKidSelected,
    super.key,
  });

  final List<KidPoints> kids;
  final Reward reward;
  final void Function(String kidId) onKidSelected;

  @override
  Widget build(BuildContext context) {
    return HabitHeroes_Dialog(
      title: 'Selecciona quién redime',
      dialogType: HabitHeroesDialogType.info,
      icon: Icons.card_giftcard,
      body: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: kids.length,
          itemBuilder: (context, index) {
            final kid = kids[index];
            final canRedeem = kid.totalPoints >= reward.points;

            return ListTile(
              enabled: canRedeem,
              leading: CircleAvatar(
                backgroundColor: kid.kidColor != null
                    ? Color(int.parse(kid.kidColor!.replaceFirst('#', '0xff')))
                    : context.colors.kidsPrimary.start,
                child: Text(
                  kid.kidName.isNotEmpty
                      ? kid.kidName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(kid.kidName),
              subtitle: Text(
                '${kid.totalPoints} puntos',
                style: TextStyle(
                  color: canRedeem
                      ? context.solidColors.success
                      : context.solidColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: canRedeem
                  ? Icon(Icons.check_circle,
                      color: context.solidColors.success)
                  : Icon(Icons.block, color: context.solidColors.error),
              onTap: canRedeem
                  ? () {
                      Navigator.of(context).pop();
                      onKidSelected(kid.kidId);
                    }
                  : null,
            );
          },
        ),
      ),
      actions: [
        HabitHeroesDialogAction(
          label: 'Cancelar',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
