import 'package:flutter/material.dart';
import 'package:mespot/data/model/restaurant.dart';
import 'package:mespot/provider/local/local_database_provider.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/widgets/restaurant_list.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurantValue();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final favoriteList = value.restaurantList ?? [];
          return switch (favoriteList.isNotEmpty) {
            true => ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  final restaurant = favoriteList[index];

                  return RestaurantList(
                    restaurant: Restaurant(
                        id: restaurant.id,
                        name: restaurant.name,
                        description: restaurant.description,
                        pictureId: restaurant.pictureId,
                        city: restaurant.city,
                        rating: restaurant.rating),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: restaurant,
                      );

                      context
                          .read<LocalDatabaseProvider>()
                          .loadAllRestaurantValue();
                    },
                  );
                },
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Favorited"),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
