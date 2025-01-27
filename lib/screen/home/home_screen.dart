import 'package:flutter/material.dart';
import 'package:mespot/provider/home/restaurant_list_provider.dart';
import 'package:mespot/screen/home/widgets/restaurant_list.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/static/restaurant_list_result_state.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';
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
            const SizedBox(height: 20),
            // Header Text
            Text("Craving", style: MespotTextStyles.displayMedium),
            Text(
              "Something",
              style: MespotTextStyles.displayMedium
                  .copyWith(color: MespotColors.green.color),
            ),
            Text("Special Today?", style: MespotTextStyles.displayMedium),
            Text(
              "Explore the best restaurants near you",
              style: MespotTextStyles.labelLarge
                  .copyWith(color: MespotColors.green.color),
            ),
            const SizedBox(height: 20),
            // Restaurant Title
            Text(
              "Restaurant",
              style: MespotTextStyles.titleLarge,
            ),
            const SizedBox(height: 20),
            // Restaurant List
            Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                // Sealed class state handling
                return switch (value.resultState) {
                  RestaurantListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    ListView.builder(
                      shrinkWrap: true, // Adjust size for nested ListView
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable scrolling for nested ListView
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
                  RestaurantListErrorState(error: var message) => Center(
                      child: Text(
                        message,
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


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MespotColors.bgColor.color,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             // Header Text
//             Text("Craving", style: MespotTextStyles.displayMedium),
//             Text(
//               "Something",
//               style: MespotTextStyles.displayMedium
//                   .copyWith(color: MespotColors.green.color),
//             ),
//             Text("Special Today?", style: MespotTextStyles.displayMedium),
//             Text(
//               "Explore the best restaurants near you",
//               style: MespotTextStyles.labelLarge
//                   .copyWith(color: MespotColors.green.color),
//             ),
//             const SizedBox(height: 20),
//             // Restaurant Title
//             Text(
//               "Restaurant",
//               style: MespotTextStyles.titleLarge,
//             ),
//             // Expanded to allow ListView to take remaining space
//             Expanded(
//               child: Consumer<RestaurantListProvider>(
//                 builder: (context, value, child) {
//                   // Sealed class state handling
//                   return switch (value.resultState) {
//                     RestaurantListLoadingState() => const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     RestaurantListLoadedState(data: var restaurantList) =>
//                       ListView.builder(
//                         itemCount: restaurantList.length,
//                         itemBuilder: (context, index) {
//                           final restaurant = restaurantList[index];

//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 8.0),
//                             child: RestaurantList(
//                               restaurant: restaurant,
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   NavigationRoute.detailRoute.name,
//                                   arguments: restaurant.id,
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     RestaurantListErrorState(error: var message) => Center(
//                         child: Text(
//                           message,
//                         ),
//                       ),
//                     _ => const SizedBox(),
//                   };
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }