import 'package:flutter/material.dart';

import '../models/wishlist_model.dart';
import '../network/network_caller.dart';
import '../network/urls.dart';

class WishlistController extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  List<WishlistModel> wishlist = [];

  Future<bool> getWishlist() async {
    _loading = true;
    notifyListeners();

    final response = await NetworkCaller.getRequest(
      Urls.wishlist,
    );

    _loading = false;

    if (response.isSuccess) {
      wishlist = WishlistResponse.fromJson(
        response.responseData!,
      ).data;

      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  Future<void> refresh() async {
    await getWishlist();
  }

  Future<bool> addToWishlist(int productId) async {
    final response = await NetworkCaller.getRequest(
      Urls.createWishlist(productId),
    );

    if (response.isSuccess) {
      await getWishlist();
      return true;
    }

    return false;
  }

  Future<bool> removeItem(int id) async {
    wishlist.removeWhere((e) => e.id == id);
    notifyListeners();
    return true;
  }

  bool isFavorite(int productId) {
    return wishlist.any(
      (element) => element.productId == productId,
    );
  }

  int get itemCount => wishlist.length;

  void clear() {
    wishlist.clear();
    notifyListeners();
  }
}
