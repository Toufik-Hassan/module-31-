class WishlistResponse {
  final String status;
  final List<WishlistModel> data;

  WishlistResponse({
    required this.status,
    required this.data,
  });

  factory WishlistResponse.fromJson(
      Map<String, dynamic> json) {
    return WishlistResponse(
      status: json["status"] ?? "",
      data: json["data"] == null
          ? []
          : List<WishlistModel>.from(
              json["data"].map(
                (x) => WishlistModel.fromJson(x),
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class WishlistModel {
  final int id;
  final int productId;
  final String productName;
  final String productImage;
  final double price;
  final double discountPrice;
  final double rating;

  WishlistModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.discountPrice,
    required this.rating,
  });

  factory WishlistModel.fromJson(
      Map<String, dynamic> json) {
    final product = json["product"] ?? {};

    return WishlistModel(
      id: json["id"] ?? 0,
      productId: product["id"] ?? 0,
      productName: product["title"] ?? "",
      productImage: product["image"] ?? "",
      price: double.tryParse(
              product["price"].toString()) ??
          0,
      discountPrice: double.tryParse(
              product["discount_price"]
                  .toString()) ??
          0,
      rating: double.tryParse(
              product["star"].toString()) ??
          0,
    );
  }

  double get finalPrice {
    if (discountPrice > 0 &&
        discountPrice < price) {
      return discountPrice;
    }
    return price;
  }

  bool get hasDiscount {
    return discountPrice > 0 &&
        discountPrice < price;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "productId": productId,
      "productName": productName,
      "productImage": productImage,
      "price": price,
      "discountPrice": discountPrice,
      "rating": rating,
    };
  }
}
