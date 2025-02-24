import 'package:mespot/data/model/restaurant_detail_response.dart';

class AddReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  AddReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) {
    return AddReviewResponse(
      error: json['error'],
      message: json['message'],
      customerReviews: (json['customerReviews'] as List)
          .map((review) => CustomerReview.fromJson(review))
          .toList(),
    );
  }
}
