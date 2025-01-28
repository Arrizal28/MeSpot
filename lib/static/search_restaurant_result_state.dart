import 'package:mespot/data/model/restaurant.dart';

sealed class SearchRestaurantResultState {}

class SearchRestaurantNoneState extends SearchRestaurantResultState {}

class SearchRestaurantLoadingState extends SearchRestaurantResultState {}

class SearchRestaurantErrorState extends SearchRestaurantResultState {
  final String error;

  SearchRestaurantErrorState(this.error);
}

class SearchRestaurantLoadedState extends SearchRestaurantResultState {
  final List<Restaurant> data;

  SearchRestaurantLoadedState(this.data);
}
