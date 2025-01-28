import 'package:flutter/material.dart';
import 'package:mespot/data/api/api_services.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  bool _isLoading = false;
  String? _error;

  AddReviewProvider(this._apiServices);

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> addReview(
    String id,
    String name,
    String review,
  ) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await _apiServices.addReview(
        id: id,
        name: name,
        review: review,
      );

      _isLoading = false;

      if (result.error) {
        _error = result.message;
        notifyListeners();
        return false;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void resetError() {
    _error = null;
    notifyListeners();
  }
}
