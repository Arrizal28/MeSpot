import 'package:mespot/data/model/restaurant_detail_response.dart';

sealed class AddReviewResultState {}

class AddReviewNoneState extends AddReviewResultState {}

class AddReviewLoadingState extends AddReviewResultState {}

class AddReviewErrorState extends AddReviewResultState {
  final String error;

  AddReviewErrorState(this.error);
}

class AddReviewLoadedState extends AddReviewResultState {
  final List<CustomerReview> data;

  AddReviewLoadedState(this.data);
}
