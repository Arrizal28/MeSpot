import 'package:flutter/material.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';

class MespotHeader extends StatelessWidget {
  final String? titleOne;
  final String? titleTwo;
  final String? titleThree;
  final String? titleSmall;
  const MespotHeader({
    super.key,
    this.titleOne = "",
    this.titleTwo = "",
    this.titleThree = "",
    this.titleSmall = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(titleOne!, style: MespotTextStyles.displayMedium),
        Text(
          titleTwo!,
          style: MespotTextStyles.displayMedium
              .copyWith(color: MespotColors.green.color),
        ),
        Text(titleThree!, style: MespotTextStyles.displayMedium),
        Text(
          titleSmall!,
          style: MespotTextStyles.labelLarge
              .copyWith(color: MespotColors.green.color),
        ),
      ],
    );
  }
}
