import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/slider_model.dart';
import '../network/network_caller.dart';
import '../network/urls.dart';

class HomeController extends ChangeNotifier {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  List<SliderModel> sliderList = [];

  List<CategoryModel> categoryList = [];

  List<ProductModel> popularProducts = [];

  List<ProductModel> specialProducts = [];

  List<ProductModel> newProducts = [];

  Future<void> loadHomeData() async {
    _inProgress = true;
    notifyListeners();

    await Future.wait([
      getSliderList(),
      getCategoryList(),
      getPopularProducts(),
      getSpecialProducts(),
      getNewProducts(),
    ]);

    _inProgress = false;
    notifyListeners();
  }

  Future<void> getSliderList() async {
    final response = await NetworkCaller.getRequest(
      Urls.sliderList,
    );

    if (response.isSuccess) {
      sliderList = SliderResponse.fromJson(
        response.responseData!,
      ).data;
    }
  }

  Future<void> getCategoryList() async {
    final response = await NetworkCaller.getRequest(
      Urls.categoryList,
    );

    if (response.isSuccess) {
      categoryList = CategoryResponse.fromJson(
        response.responseData!,
      ).data;
    }
  }

  Future<void> getPopularProducts() async {
    final response = await NetworkCaller.getRequest(
      Urls.productByRemark("popular"),
    );

    if (response.isSuccess) {
      popularProducts = ProductResponse.fromJson(
        response.responseData!,
      ).data;
    }
  }

  Future<void> getSpecialProducts() async {
    final response = await NetworkCaller.getRequest(
      Urls.productByRemark("special"),
    );

    if (response.isSuccess) {
      specialProducts = ProductResponse.fromJson(
        response.responseData!,
      ).data;
    }
  }

  Future<void> getNewProducts() async {
    final response = await NetworkCaller.getRequest(
      Urls.productByRemark("new"),
    );

    if (response.isSuccess) {
      newProducts = ProductResponse.fromJson(
        response.responseData!,
      ).data;
    }
  }

  Future<void> refreshHome() async {
    sliderList.clear();
    categoryList.clear();
    popularProducts.clear();
    specialProducts.clear();
    newProducts.clear();

    await loadHomeData();
  }
}
