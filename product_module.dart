class ProductResponse {
  final String status;
  final List<ProductModel> data;

  ProductResponse({
    required this.status,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'] ?? '',
      data: json['data'] == null
          ? []
          : List<ProductModel>.from(
              json['data'].map(
                (x) => ProductModel.fromJson(x),
              ),
            ),
    );
  }
}

class ProductModel {
  final int id;
  final String title;
  final String shortDes;
  final double price;
  final double discountPrice;
  final String image;
  final double star;
  final String remark;
  final int categoryId;
  final int brandId;
  final String createdAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.shortDes,
    required this.price,
    required this.discountPrice,
    required this.image,
    required this.star,
    required this.remark,
    required this.categoryId,
    required this.brandId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      shortDes: json['short_des'] ?? '',
      price: double.tryParse(
              json['price'].toString()) ??
          0,
      discountPrice: double.tryParse(
              json['discount_price']
                  .toString()) ??
          0,
      image: json['image'] ?? '',
      star: double.tryParse(
              json['star'].toString()) ??
          0,
      remark: json['remark'] ?? '',
      categoryId: json['category_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "short_des": shortDes,
      "price": price,
      "discount_price": discountPrice,
      "image": image,
      "star": star,
      "remark": remark,
      "category_id": categoryId,
      "brand_id": brandId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }

  bool get hasDiscount =>
      discountPrice > 0 &&
      discountPrice < price;

  double get finalPrice =>
      hasDiscount ? discountPrice : price;
}
