import 'package:flutter/material.dart';

import '../models/review_model.dart';
import '../network/network_caller.dart';
import '../network/urls.dart';

class ReviewController extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  List<ReviewModel> reviewList = [];

  String errorMessage = "";

  Future<bool> getReviews(int productId) async {
    _loading = true;
    errorMessage = "";
    notifyListeners();

    final response = await NetworkCaller.getRequest(
      Urls.reviewList(productId),
    );

    _loading = false;

    if (response.isSuccess) {
      reviewList = ReviewResponse.fromJson(
        response.responseData!,
      ).data;

      notifyListeners();
      return true;
    }

    errorMessage =
        response.errorMessage ?? "Failed to load reviews";

    notifyListeners();
    return false;
  }

  Future<bool> addReview({
    required int productId,
    required String description,
    required double rating,
  }) async {
    _loading = true;
    notifyListeners();

    final response = await NetworkCaller.postRequest(
      Urls.createReview,
      {
        "product_id": productId,
        "description": description,
        "rating": rating,
      },
    );

    _loading = false;
    notifyListeners();

    if (response.isSuccess) {
      await getReviews(productId);
      return true;
    }

    return false;
  }

  Future<void> refresh(int productId) async {
    await getReviews(productId);
  }

  double get averageRating {
    if (reviewList.isEmpty) return 0;

    double total = 0;

    for (ReviewModel item in reviewList) {
      total += item.rating;
    }

    return total / reviewList.length;
  }

  int get totalReview => reviewList.length;

  bool get hasReview => reviewList.isNotEmpty;

  void clear() {
    reviewList.clear();
    notifyListeners();
  }
}
