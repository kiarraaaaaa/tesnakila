class ReviewModel {
  final String id;

  final String campusId;

  final String userId;
  final String userName;

  final String userImage;

  final String reviewText;

  final String reviewImage;

  final double rating;

  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.campusId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.reviewText,
    required this.reviewImage,
    required this.rating,
    required this.createdAt,
  });

  factory ReviewModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ReviewModel(
      id: map["id"] ?? "",

      campusId:
          map["campusId"] ?? "",

      userId:
          map["userId"] ?? "",

      userName:
          map["userName"] ?? "",

      userImage:
          map["userImage"] ?? "",

      reviewText:
          map["reviewText"] ?? "",

      reviewImage:
          map["reviewImage"] ?? "",

      rating:
          (map["rating"] ?? 0)
              .toDouble(),

      createdAt:
          DateTime.tryParse(
                map["createdAt"] ??
                    "",
              ) ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "campusId": campusId,
      "userId": userId,
      "userName": userName,
      "userImage": userImage,
      "reviewText": reviewText,
      "reviewImage": reviewImage,
      "rating": rating,
      "createdAt":
          createdAt.toIso8601String(),
    };
  }
}