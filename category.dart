class CategoryResponse {
  final String status;
  final List<CategoryModel> data;

  CategoryResponse({
    required this.status,
    required this.data,
  });

  factory CategoryResponse.fromJson(
      Map<String, dynamic> json) {
    return CategoryResponse(
      status: json["status"] ?? "",
      data: json["data"] == null
          ? []
          : List<CategoryModel>.from(
              json["data"].map(
                (x) => CategoryModel.fromJson(x),
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

class CategoryModel {
  final int id;
  final String categoryName;
  final String categoryImg;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryImg,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(
      Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"] ?? 0,
      categoryName: json["categoryName"] ?? "",
      categoryImg: json["categoryImg"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "categoryName": categoryName,
      "categoryImg": categoryImg,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
