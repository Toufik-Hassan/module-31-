import 'package:flutter/material.dart';

import '../models/product_details_model.dart';
import '../models/product_model.dart';
import '../network/network_caller.dart';
import '../network/urls.dart';

class ProductController extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  ProductDetailsModel? product;

  List<ProductModel> relatedProducts = [];

  int quantity = 1;

  String selectedColor = '';

  String selectedSize = '';

  String errorMessage = '';

  Future<bool> getProductDetails(int productId) async {
    _loading = true;
    errorMessage = "";
    notifyListeners();

    final response = await NetworkCaller.getRequest(
      Urls.productDetails(productId),
    );

    _loading = false;

    if (response.isSuccess) {
      final model = ProductDetailsResponse.fromJson(
        response.responseData!,
      );

      if (model.data.isNotEmpty) {
        product = model.data.first;

        if (product!.colorList.isNotEmpty) {
          selectedColor = product!.colorList.first;
        }

        if (product!.sizeList.isNotEmpty) {
          selectedSize = product!.sizeList.first;
        }

        notifyListeners();

        await getRelatedProducts(
          product!.categoryId,
        );

        return true;
      }
    }

    errorMessage =
        response.errorMessage ?? "Product not found";

    notifyListeners();

    return false;
  }

  Future<void> getRelatedProducts(
      int categoryId) async {
    final response = await NetworkCaller.getRequest(
      Urls.productByCategory(categoryId),
    );

    if (response.isSuccess) {
      relatedProducts = ProductResponse.fromJson(
        response.responseData!,
      ).data;

      notifyListeners();
    }
  }

  void increaseQuantity() {
    quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void selectColor(String color) {
    selectedColor = color;
    notifyListeners();
  }

  void selectSize(String size) {
    selectedSize = size;
    notifyListeners();
  }

  Future<bool> addToCart() async {
    if (product == null) return false;

    _loading = true;
    notifyListeners();

    final response = await NetworkCaller.postRequest(
      Urls.createCart,
      {
        "product_id": product!.id,
        "color": selectedColor,
        "size": selectedSize,
        "qty": quantity,
      },
    );

    _loading = false;
    notifyListeners();

    return response.isSuccess;
  }

  double get totalPrice {
    if (product == null) return 0;

    return product!.finalPrice * quantity;
  }

  void reset() {
    quantity = 1;
    selectedColor = "";
    selectedSize = "";
    relatedProducts.clear();
    product = null;
    errorMessage = "";
    notifyListeners();
  }
}
