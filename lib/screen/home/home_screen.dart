import 'package:flutter/material.dart';
import 'package:mespot/provider/home/restaurant_list_provider.dart';
import 'package:mespot/widgets/restaurant_list.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/static/restaurant_list_result_state.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';
import 'package:mespot/widgets/mespot_header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const MespotHeader(
              titleOne: 'Craving',
              titleTwo: "Something",
              titleThree: "Special Today?",
              titleSmall: "Explore the best restaurants near you",
            ),
            const SizedBox(height: 20),
            Text(
              "Restaurant",
              style: MespotTextStyles.titleLarge,
            ),
            const SizedBox(height: 20),
            Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: RestaurantList(
                            restaurant: restaurant,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRoute.detailRoute.name,
                                arguments: restaurant,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  RestaurantListErrorState() => Center(
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
