import 'package:flutter/material.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final String review;

  const ReviewItem(
      {super.key,
      required this.name,
      required this.date,
      required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: MespotTextStyles.titleSmall.copyWith(
                  color: MespotColors.green.color, fontWeight: FontWeight.bold),
            ),
            Text(
              date,
              style: MespotTextStyles.titleSmall,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          review,
          style: MespotTextStyles.titleSmall,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
