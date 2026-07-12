import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../network/network_caller.dart';
import '../network/urls.dart';

class CartController extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  List<CartModel> cartList = [];

  Future<bool> getCartList() async {
    _loading = true;
    notifyListeners();

    final response =
        await NetworkCaller.getRequest(Urls.cartList);

    _loading = false;

    if (response.isSuccess) {
      cartList = CartResponse.fromJson(
        response.responseData!,
      ).data;

      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  double get totalPrice {
    double total = 0;

    for (CartModel item in cartList) {
      total += item.totalPrice;
    }

    return total;
  }

  Future<void> refreshCart() async {
    await getCartList();
  }

  Future<bool> deleteCartItem(int id) async {
    final response = await NetworkCaller.getRequest(
      Urls.deleteCart(id),
    );

    if (response.isSuccess) {
      cartList.removeWhere(
        (element) => element.id == id,
      );

      notifyListeners();

      return true;
    }

    return false;
  }

  void increaseQty(int index) {
    CartModel item = cartList[index];

    cartList[index] = item.copyWith(
      quantity: item.quantity + 1,
      totalPrice:
          item.unitPrice * (item.quantity + 1),
    );

    notifyListeners();
  }

  void decreaseQty(int index) {
    CartModel item = cartList[index];

    if (item.quantity > 1) {
      cartList[index] = item.copyWith(
        quantity: item.quantity - 1,
        totalPrice:
            item.unitPrice * (item.quantity - 1),
      );

      notifyListeners();
    }
  }

  void clearCart() {
    cartList.clear();
    notifyListeners();
  }
}
