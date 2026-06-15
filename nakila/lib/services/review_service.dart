

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/review_model.dart';

class ReviewService {
  Future<void> addReply({
  required String reviewId,
  required Map<String, dynamic> reply,
}) async {

  await _firestore
      .collection("reviews")
      .doc(reviewId)
      .update({

    "replies":
        FieldValue.arrayUnion(
      [reply],
    ),
  });
}
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;



  Future<void> addReview({
    required ReviewModel review,
  }) async {

    await _firestore
        .collection("reviews")
        .doc(review.id)
        .set(
          review.toMap(),
        );
  }
 Future<void> deleteReview(
  String reviewId,
) async {

  await _firestore
      .collection("reviews")
      .doc(reviewId)
      .delete();
}
Stream<List<ReviewModel>>
    getAllReviews() {

  return _firestore
      .collection("reviews")
      .snapshots()
      .map((snapshot) {

    return snapshot.docs
        .map(
          (doc) =>
              ReviewModel.fromMap(
            doc.data(),
          ),
        )
        .toList();
  });
}
  Stream<List<ReviewModel>>
      getReviewsByCampus(
    String campusId,
  ) {

    return _firestore
        .collection("reviews")
.where(
  "campusId",
  isEqualTo: campusId,
)
.snapshots()
        .map((snapshot) {

      return snapshot.docs
          .map(
            (doc) =>
                ReviewModel.fromMap(
              doc.data(),
            ),
          )
          .toList();
    });
  }
}