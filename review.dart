class ReviewResponse {
  final String status;
  final List<ReviewModel> data;

  ReviewResponse({
    required this.status,
    required this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      status: json["status"] ?? "",
      data: json["data"] == null
          ? []
          : List<ReviewModel>.from(
              json["data"].map(
                (x) => ReviewModel.fromJson(x),
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

class ReviewModel {
  final int id;
  final String description;
  final double rating;
  final String customerName;
  final String customerEmail;
  final String createdAt;

  ReviewModel({
    required this.id,
    required this.description,
    required this.rating,
    required this.customerName,
    required this.customerEmail,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final profile = json["profile"] ?? {};

    String firstName = profile["cus_name"] ??
        profile["firstName"] ??
        "";

    String lastName = profile["cus_add"] ??
        profile["lastName"] ??
        "";

    return ReviewModel(
      id: json["id"] ?? 0,
      description: json["description"] ?? "",
      rating: double.tryParse(
            json["rating"].toString(),
          ) ??
          5,
      customerName:
          "$firstName $lastName".trim(),
      customerEmail:
          profile["cus_email"] ??
              profile["email"] ??
              "",
      createdAt:
          json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "rating": rating,
      "customerName": customerName,
      "customerEmail": customerEmail,
      "createdAt": createdAt,
    };
  }
}
