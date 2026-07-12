class CartResponse {
  final String status;
  final List<CartModel> data;

  CartResponse({
    required this.status,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      status: json["status"] ?? "",
      data: json["data"] == null
          ? []
          : List<CartModel>.from(
              json["data"].map(
                (x) => CartModel.fromJson(x),
              ),
            ),
    );
  }
}

class CartModel {
  final int id;
  final int productId;
  final String productName;
  final String productImage;
  final double unitPrice;
  final int quantity;
  final String color;
  final String size;
  final double totalPrice;

  CartModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.unitPrice,
    required this.quantity,
    required this.color,
    required this.size,
    required this.totalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final product = json["product"] ?? {};

    final unitPrice = double.tryParse(
          (product["price"] ?? 0).toString(),
        ) ??
        0;

    final quantity = int.tryParse(
          (json["qty"] ?? 1).toString(),
        ) ??
        1;

    return CartModel(
      id: json["id"] ?? 0,
      productId: product["id"] ?? 0,
      productName: product["title"] ?? "",
      productImage: product["image"] ?? "",
      unitPrice: unitPrice,
      quantity: quantity,
      color: json["color"] ?? "",
      size: json["size"] ?? "",
      totalPrice: unitPrice * quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "productId": productId,
      "productName": productName,
      "productImage": productImage,
      "unitPrice": unitPrice,
      "quantity": quantity,
      "color": color,
      "size": size,
      "totalPrice": totalPrice,
    };
  }

  CartModel copyWith({
    int? id,
    int? productId,
    String? productName,
    String? productImage,
    double? unitPrice,
    int? quantity,
    String? color,
    String? size,
    double? totalPrice,
  }) {
    return CartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  bool get isValid =>
      productId != 0 &&
      productName.isNotEmpty;

  String get formattedPrice =>
      "৳${totalPrice.toStringAsFixed(2)}";
}
