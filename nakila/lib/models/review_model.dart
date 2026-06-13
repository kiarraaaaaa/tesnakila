class ReviewModel {
  final String id;

  final String campusId;

  final String userId;
  final String userName;
  final List<Map<String, dynamic>> replies;
  final String userImage;

  final String reviewText;

  final List<String> reviewImages;

  final double rating;

  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.campusId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.reviewText,
    required this.reviewImages,
    required this.rating,
    required this.createdAt,
this.replies = const [],
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

      reviewImages:
    List<String>.from(
      map["reviewImages"] ?? [],
    ),

      rating:
          (map["rating"] ?? 0)
              .toDouble(),

      createdAt:
          DateTime.tryParse(
                map["createdAt"] ??
                    "",
              ) ??
              DateTime.now(),
              replies:
    List<Map<String, dynamic>>.from(
      map["replies"] ?? [],
    ),

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
      "reviewImages": reviewImages,
      "rating": rating,
      "createdAt":
          createdAt.toIso8601String(),
          "replies": replies,
    };
  }
}