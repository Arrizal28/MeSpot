import 'package:flutter/material.dart';
import 'package:mespot/data/api/api_services.dart';
import 'package:mespot/data/model/restaurant.dart';
import 'package:mespot/provider/detail/add_review_provider.dart';
import 'package:mespot/provider/detail/restaurant_detail_provider.dart';
import 'package:mespot/provider/home/restaurant_list_provider.dart';
import 'package:mespot/provider/local/local_database_provider.dart';
import 'package:mespot/provider/main/index_nav_provider.dart';
import 'package:mespot/provider/search/search_restaurant_provider.dart';
import 'package:mespot/screen/addreview/add_review_screen.dart';
import 'package:mespot/screen/favorite/favorite_screen.dart';
import 'package:mespot/screen/detail/detail_screen.dart';
import 'package:mespot/screen/main/main_screen.dart';
import 'package:mespot/screen/more/more_screen.dart';
import 'package:mespot/screen/search/search_screen.dart';
import 'package:mespot/data/local/local_database_service.dart.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/style/theme/mespot_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AddReviewProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchRestaurantProvider(
            context.read<ApiServices>(),
          ),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeSpot',
      theme: MespotTheme.lightTheme,
      darkTheme: MespotTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurant:
                  ModalRoute.of(context)!.settings.arguments as Restaurant,
            ),
        NavigationRoute.searchRoute.name: (context) => const SearchScreen(),
        NavigationRoute.addRoute.name: (context) => AddReviewScreen(
              restaurantId:
                  ModalRoute.of(context)!.settings.arguments as String,
            ),
        NavigationRoute.favoriteRoute.name: (context) => const FavoriteScreen(),
        NavigationRoute.moreRoute.name: (context) => const MoreScreen(),
      },
    );
  }
}
