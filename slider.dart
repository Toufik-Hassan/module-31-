class SliderResponse {
  final String status;
  final List<SliderModel> data;

  SliderResponse({
    required this.status,
    required this.data,
  });

  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return SliderResponse(
      status: json["status"] ?? "",
      data: json["data"] == null
          ? []
          : List<SliderModel>.from(
              json["data"].map(
                (x) => SliderModel.fromJson(x),
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

class SliderModel {
  final int id;
  final String title;
  final String shortDescription;
  final String image;
  final int productId;
  final String createdAt;
  final String updatedAt;

  SliderModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.image,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      shortDescription: json["short_des"] ?? "",
      image: json["image"] ?? "",
      productId: json["product_id"] ?? 0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "short_des": shortDescription,
      "image": image,
      "product_id": productId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
