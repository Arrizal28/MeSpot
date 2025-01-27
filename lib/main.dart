import 'package:flutter/material.dart';
import 'package:mespot/data/api/api_services.dart';
import 'package:mespot/provider/detail/restaurant_detail_provider.dart';
import 'package:mespot/provider/home/restaurant_list_provider.dart';
import 'package:mespot/provider/main/index_nav_provider.dart';
import 'package:mespot/screen/detail/detail_screen.dart';
import 'package:mespot/screen/main/main_screen.dart';
import 'package:mespot/screen/search/search_screen.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/style/theme/mespot_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        // todo-04-inject-02: register the tourism detail provider
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
              args: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        NavigationRoute.searchRoute.name: (context) => const SearchScreen(),
      },
    );
  }
}
