import 'package:mespot/data/model/restaurant.dart';

class SearchRestaurantResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return SearchRestaurantResponse(
      error: json["error"],
      founded: json["founded"],
      restaurants: json["restaurants"] != null
          ? List<Restaurant>.from(
              json["restaurants"]!.map((x) => Restaurant.fromJson(x)))
          : <Restaurant>[],
    );
  }
}
