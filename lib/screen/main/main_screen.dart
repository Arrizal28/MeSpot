import 'package:flutter/material.dart';
import 'package:mespot/provider/main/index_nav_provider.dart';
import 'package:mespot/screen/home/home_screen.dart';
import 'package:mespot/screen/search/search_screen.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            _ => const SearchScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MespotColors.green.color,
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<IndexNavProvider>().setIndextBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            tooltip: "Search",
          ),
        ],
      ),
    );
  }
}
