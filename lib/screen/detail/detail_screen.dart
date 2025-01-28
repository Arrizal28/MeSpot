import 'package:flutter/material.dart';
import 'package:mespot/provider/detail/restaurant_detail_provider.dart';
import 'package:mespot/screen/detail/widgets/body_of_detail_screen.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.args["pictureId"],
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/${widget.args["pictureId"]}",
                fit: BoxFit.cover,
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
                      onReviewSubmitted: () {
                        value.fetchRestaurantDetail(restaurant.id);
                      },
                    ),
                  RestaurantDetailErrorState(error: var message) => Center(
                      child: Text(message),
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
