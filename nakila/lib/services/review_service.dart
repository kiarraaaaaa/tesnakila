import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/review_model.dart';

class ReviewService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  Future<String> uploadReviewImage(
    File image,
  ) async {

    String fileName =
        DateTime.now()
            .millisecondsSinceEpoch
            .toString();

    Reference ref = _storage
        .ref()
        .child(
          "review_images/$fileName.jpg",
        );

    UploadTask uploadTask =
        ref.putFile(image);

    TaskSnapshot snapshot =
        await uploadTask;

    return await snapshot.ref
        .getDownloadURL();
  }

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