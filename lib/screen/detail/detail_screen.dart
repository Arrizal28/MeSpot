import 'package:flutter/material.dart';
import 'package:mespot/provider/detail/restaurant_detail_provider.dart';
import 'package:mespot/static/navigation_route.dart';
import 'package:mespot/widgets/body_of_detail_screen.dart';
import 'package:mespot/static/restaurant_detail_result_state.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  const DetailScreen({
    super.key,
    required this.args,
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
          .fetchRestaurantDetail(widget.args["id"]);
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
              arguments: widget.args["id"]);

          if (result == true && mounted) {
            context
                .read<RestaurantDetailProvider>()
                .fetchRestaurantDetail(widget.args["id"]);
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
            Hero(
              tag: widget.args["pictureId"],
              placeholderBuilder: (context, heroSize, child) {
                return child;
              },
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/${widget.args["pictureId"]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
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
