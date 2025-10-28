import 'package:flutter/material.dart';

import '../../../../../shared/models/kid_points.dart';
import '../../../../../shared/models/reward.dart';

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
    return AlertDialog(
      title: const Text('Selecciona quién redime'),
      content: SizedBox(
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
                    : Colors.blue,
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
                  color: canRedeem ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: canRedeem
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.block, color: Colors.red),
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
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
