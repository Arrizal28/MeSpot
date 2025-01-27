import 'package:flutter/material.dart';
import 'package:mespot/data/model/restaurant_detail_response.dart';
import 'package:mespot/provider/detail/restaurant_detail_provider.dart';
import 'package:mespot/static/restaurant_detail_result_state.dart';
import 'package:mespot/style/colors/mespot_colors.dart';
import 'package:mespot/style/typography/mespot_text_styles.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0, 4), // Posisi shadow (x, y)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Papa sean",
                        style: MespotTextStyles.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Medan",
                        style: MespotTextStyles.titleSmall
                            .copyWith(color: MespotColors.green.color),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 24), // Gambar bintang
                          const SizedBox(width: 4),
                          Text(
                            "4.3 (43 Reviews)", // Menampilkan rating dengan 1 desimal
                            style: MespotTextStyles.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 24), // Gambar bintang
                          const SizedBox(width: 4),
                          Text(
                            "Jln. Pandeglang no 19", // Menampilkan rating dengan 1 desimal
                            style: MespotTextStyles.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(0, 4), // Posisi shadow (x, y)
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "About Restaurant",
                        style: MespotTextStyles.titleLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                        style: MespotTextStyles.titleSmall,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Categories",
                        style: MespotTextStyles.titleLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 12.0, // Jarak horizontal antar item
                              runSpacing: 8.0, // Jarak vertikal antar item
                              children: [
                                Chip(label: Text("Italia")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Foods",
                        style: MespotTextStyles.titleLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 12.0, // Jarak horizontal antar item
                              runSpacing: 8.0, // Jarak vertikal antar item
                              children: [
                                Chip(label: Text("Italia")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Drinks",
                        style: MespotTextStyles.titleLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 12.0, // Jarak horizontal antar item
                              runSpacing: 8.0, // Jarak vertikal antar item
                              children: [
                                Chip(label: Text("Italia")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                                Chip(label: Text("Modern")),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Add Review",
                        style: MespotTextStyles.titleLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: "Your Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "Your Review",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Submit review logic
                        },
                        child: const Text("Submit Review"),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Reviews",
                        style: MespotTextStyles.titleLarge
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "zaky cahyo hadi",
                            style: MespotTextStyles.titleSmall.copyWith(
                                color: MespotColors.green.color,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "27 Januari 2025",
                            style: MespotTextStyles.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                        style: MespotTextStyles.titleSmall,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "zaky cahyo hadi",
                            style: MespotTextStyles.titleSmall.copyWith(
                                color: MespotColors.green.color,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "27 Januari 2025",
                            style: MespotTextStyles.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                        style: MespotTextStyles.titleSmall,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: DecoratedBox(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "zaky cahyo hadi",
                            style: MespotTextStyles.titleSmall.copyWith(
                                color: MespotColors.green.color,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "27 Januari 2025",
                            style: MespotTextStyles.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                        style: MespotTextStyles.titleSmall,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
