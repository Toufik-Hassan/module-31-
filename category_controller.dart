import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../network/network_caller.dart';
import '../network/urls.dart';

class CategoryController extends ChangeNotifier {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  List<ProductModel> categoryProducts = [];

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> getProductsByCategory(int categoryId) async {
    _inProgress = true;
    _errorMessage = "";
    notifyListeners();

    final response = await NetworkCaller.getRequest(
      Urls.productByCategory(categoryId),
    );

    _inProgress = false;

    if (response.isSuccess) {
      categoryProducts = ProductResponse.fromJson(
        response.responseData!,
      ).data;

      notifyListeners();
      return true;
    } else {
      _errorMessage =
          response.errorMessage ?? "Something went wrong";

      notifyListeners();
      return false;
    }
  }

  Future<void> refreshCategory(int categoryId) async {
    categoryProducts.clear();
    notifyListeners();

    await getProductsByCategory(categoryId);
  }

  void clearProducts() {
    categoryProducts.clear();
    notifyListeners();
  }

  ProductModel? findProductById(int id) {
    try {
      return categoryProducts.firstWhere(
        (element) => element.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  int get totalProducts => categoryProducts.length;

  bool get hasData => categoryProducts.isNotEmpty;

  bool get isEmpty => categoryProducts.isEmpty;
}
