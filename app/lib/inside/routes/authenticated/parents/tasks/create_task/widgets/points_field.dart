import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../outside/theme/theme.dart';
import '../../../../../../../shared/widgets/all.dart';
import '../../../../../../i18n/translations.g.dart';

class CreateTask_Widget_PointsField extends StatelessWidget {
  final TextEditingController controller;

  const CreateTask_Widget_PointsField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ColorfulTextField(
          label: t.tasks.points,
          hint: t.tasks.pointsHint,
          controller: controller,
          gradient: context.colors.pointsGold,
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.star),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        if (t.tasks.pointsDescription.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            t.tasks.pointsDescription,
            style: TextStyle(
              fontSize: 12,
              color: context.solidColors.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
