import 'package:flutter/material.dart';
import 'package:mespot/data/model/restaurant.dart';
import 'package:mespot/provider/detail/favorite_icon_provider.dart';
import 'package:mespot/provider/local/local_database_provider.dart';
import 'package:provider/provider.dart';

class IconFavorite extends StatefulWidget {
  final Restaurant restaurant;

  const IconFavorite({super.key, required this.restaurant});

  @override
  State<IconFavorite> createState() => _IconFavoriteState();
}

class _IconFavoriteState extends State<IconFavorite> {
  @override
  void initState() {
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final bookmarkIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantValueById(widget.restaurant.id);
      final value = localDatabaseProvider.restaurant == null
          ? false
          : localDatabaseProvider.restaurant!.id == widget.restaurant.id;

      bookmarkIconProvider.isFavorited = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;

        if (!isFavorited) {
          await localDatabaseProvider.saveRestaurantValue(widget.restaurant);
        } else {
          await localDatabaseProvider
              .removeRestaurantValueById(widget.restaurant.id);
        }
        favoriteIconProvider.isFavorited = !isFavorited;
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
