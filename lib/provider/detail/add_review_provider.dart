import 'package:flutter/material.dart';
import 'package:mespot/data/api/api_services.dart';
import 'package:mespot/static/add_review_result_state.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  AddReviewProvider(
    this._apiServices,
  );

  AddReviewResultState _resultState = AddReviewNoneState();

  AddReviewResultState get resultState => _resultState;

  Future<void> fetchAddReview(String id, String name, String review) async {
    try {
      _resultState = AddReviewLoadingState();
      notifyListeners();

      final result =
          await _apiServices.addReview(id: id, name: name, review: review);

      if (result.error == true) {
        _resultState = AddReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = AddReviewLoadedState(result);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = AddReviewErrorState(e.toString());
      notifyListeners();
    }
  }
}
