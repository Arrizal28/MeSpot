import 'package:flutter/material.dart';
import 'package:mespot/data/model/restaurant_detail_response.dart';
import 'package:mespot/screen/detail/widgets/restaurant_info.dart';
import 'package:mespot/screen/detail/widgets/review_form.dart';
import 'package:mespot/screen/detail/widgets/review_item.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';

class BodyOfDetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onReviewSubmitted;
  const BodyOfDetailScreen(
      {super.key, required this.restaurant, required this.onReviewSubmitted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantInfo(
          name: restaurant.name,
          city: restaurant.city,
          address: restaurant.address,
          rating: restaurant.rating,
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: double.infinity,
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
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "About Restaurant",
                    style: MespotTextStyles.titleLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    restaurant.description,
                    style: MespotTextStyles.titleSmall,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Categories",
                    style: MespotTextStyles.titleLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 12.0,
                          runSpacing: 8.0,
                          children: restaurant.categories.map((category) {
                            return Chip(
                              label: Text(
                                category.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: MespotColors.green.color,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Foods and Drinks",
                    style: MespotTextStyles.titleLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 12.0,
                          runSpacing: 8.0,
                          children: [
                            ...restaurant.menus.foods.map((food) {
                              return Chip(
                                label: Text(
                                  food.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: MespotColors.green.color,
                              );
                            }),
                            ...restaurant.menus.drinks.map((drink) {
                              return Chip(
                                label: Text(
                                  drink.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: MespotColors.green.color,
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Drinks",
                    style: MespotTextStyles.titleLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Add Review",
                    style: MespotTextStyles.titleLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ReviewForm(
                    restaurantId: restaurant.id,
                    onReviewSubmitted: onReviewSubmitted,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Reviews",
                    style: MespotTextStyles.titleLarge
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: restaurant.customerReviews.map((reviews) {
                      return ReviewItem(
                          name: reviews.name,
                          date: reviews.date,
                          review: reviews.review);
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
