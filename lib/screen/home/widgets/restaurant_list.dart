import 'package:flutter/material.dart';
import 'package:mespot/data/model/restaurant.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';

class RestaurantList extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;
  const RestaurantList(
      {super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 4), // Posisi shadow (x, y)
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}")))),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(restaurant.name,
                      style: MespotTextStyles.titleLarge
                          .copyWith(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.amber, size: 24), // Gambar bintang
                      const SizedBox(width: 4),
                      Text(
                        restaurant.rating
                            .toString(), // Menampilkan rating dengan 1 desimal
                        style: MespotTextStyles.titleSmall
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.location_on,
                      color: MespotColors.green.color,
                      size: 24), // Gambar bintang
                  const SizedBox(width: 4),
                  Text(restaurant.city, // Menampilkan rating dengan 1 desimal
                      style: MespotTextStyles.titleSmall
                          .copyWith(color: MespotColors.green.color)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          )),
    );
  }
}
