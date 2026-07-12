class ProductDetailsResponse {
  final String status;
  final List<ProductDetailsModel> data;

  ProductDetailsResponse({
    required this.status,
    required this.data,
  });

  factory ProductDetailsResponse.fromJson(
      Map<String, dynamic> json) {
    return ProductDetailsResponse(
      status: json["status"] ?? "",
      data: json["data"] == null
          ? []
          : List<ProductDetailsModel>.from(
              json["data"].map(
                (x) =>
                    ProductDetailsModel.fromJson(x),
              ),
            ),
    );
  }
}

class ProductDetailsModel {
  final int id;
  final String title;
  final String shortDes;
  final String description;
  final double price;
  final double discountPrice;
  final String image;
  final double star;
  final String color;
  final String size;
  final String remark;
  final int categoryId;
  final int brandId;
  final String createdAt;
  final String updatedAt;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.shortDes,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.image,
    required this.star,
    required this.color,
    required this.size,
    required this.remark,
    required this.categoryId,
    required this.brandId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDetailsModel.fromJson(
      Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      shortDes: json["short_des"] ?? "",
      description: json["des"] ?? "",
      price: double.tryParse(
              json["price"].toString()) ??
          0,
      discountPrice: double.tryParse(
              json["discount_price"].toString()) ??
          0,
      image: json["image"] ?? "",
      star: double.tryParse(
              json["star"].toString()) ??
          0,
      color: json["color"] ?? "",
      size: json["size"] ?? "",
      remark: json["remark"] ?? "",
      categoryId: json["category_id"] ?? 0,
      brandId: json["brand_id"] ?? 0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  List<String> get colorList {
    if (color.isEmpty) return [];
    return color.split(",");
  }

  List<String> get sizeList {
    if (size.isEmpty) return [];
    return size.split(",");
  }

  bool get hasDiscount {
    return discountPrice > 0 &&
        discountPrice < price;
  }

  double get finalPrice {
    return hasDiscount
        ? discountPrice
        : price;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "short_des": shortDes,
      "des": description,
      "price": price,
      "discount_price": discountPrice,
      "image": image,
      "star": star,
      "color": color,
      "size": size,
      "remark": remark,
      "category_id": categoryId,
      "brand_id": brandId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
