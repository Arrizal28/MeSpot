import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mespot/provider/search/search_restaurant_provider.dart';
import 'package:mespot/widgets/restaurant_list.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/static/search_restaurant_result_state.dart';
import 'package:provider/provider.dart';

class MespotSearchTextField extends StatefulWidget {
  const MespotSearchTextField({
    super.key,
  });

  @override
  State<MespotSearchTextField> createState() => _MespotSearchTextFieldState();
}

class _MespotSearchTextFieldState extends State<MespotSearchTextField> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _submitReview(String query) {
    final searchRestaurantProvider = context.read<SearchRestaurantProvider>();

    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchRestaurantProvider.fetchSearchRestaurant(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: _submitReview,
          decoration: InputDecoration(
            hintText: "Search...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
        const SizedBox(height: 20),
        Consumer<SearchRestaurantProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              SearchRestaurantLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              SearchRestaurantLoadedState(data: var searchRestaurant) =>
                searchRestaurant.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 52,
                            ),
                            Image.asset(
                              "assets/images/error.jpg",
                              width: 198,
                              height: 198,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              "No restaurants found.",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchRestaurant.length,
                        itemBuilder: (context, index) {
                          final restaurant = searchRestaurant[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: RestaurantList(
                              restaurant: restaurant,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  NavigationRoute.detailRoute.name,
                                  arguments: {
                                    'id': restaurant.id,
                                    'pictureId': restaurant.pictureId,
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
              SearchRestaurantErrorState() => Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 52,
                      ),
                      Image.asset(
                        "assets/images/error.jpg",
                        width: 198,
                        height: 198,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "Oops! Something went wrong.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              _ => Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 52,
                      ),
                      Image.asset(
                        "assets/images/searchnonstate.jpg",
                        width: 198,
                        height: 198,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "Search for anything...",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            };
          },
        ),
      ],
    );
  }
}
