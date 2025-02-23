import 'package:flutter/material.dart';
import 'package:mespot/data/model/restaurant.dart';
import 'package:mespot/provider/detail/favorite_icon_provider.dart';
import 'package:mespot/provider/detail/restaurant_detail_provider.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/widgets/body_of_detail_screen.dart';
import 'package:mespot/static/restaurant_detail_result_state.dart';
import 'package:mespot/widgets/icon_favorite.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  // final Map<String, dynamic> args;
  final Restaurant restaurant;
  const DetailScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurant.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Information"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
              context, NavigationRoute.addRoute.name,
              arguments: widget.restaurant.id);

          if (result == true && mounted) {
            context
                .read<RestaurantDetailProvider>()
                .fetchRestaurantDetail(widget.restaurant.id);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        splashColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip
                  .none, // Penting! Agar widget child bisa keluar dari bounds Stack
              children: [
                Hero(
                  tag: widget.restaurant.pictureId,
                  placeholderBuilder: (context, heroSize, child) {
                    return child;
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${widget.restaurant.pictureId}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom:
                      -20, // Nilai negatif untuk membuat icon keluar dari image
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ChangeNotifierProvider(
                      create: (context) => FavoriteIconProvider(),
                      child: Consumer<RestaurantDetailProvider>(
                        builder: (context, value, child) {
                          return switch (value.resultState) {
                            RestaurantDetailLoadedState(data: var restaurant) =>
                              IconFavorite(
                                  restaurant: Restaurant(
                                      id: restaurant.id,
                                      name: restaurant.name,
                                      description: restaurant.description,
                                      pictureId: restaurant.pictureId,
                                      city: restaurant.city,
                                      rating: restaurant.rating)),
                            _ => const SizedBox(),
                          };
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  RestaurantDetailLoadedState(data: var restaurant) =>
                    BodyOfDetailScreen(
                      restaurant: restaurant,
                    ),
                  RestaurantDetailErrorState() => Center(
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
                  _ => const SizedBox(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
