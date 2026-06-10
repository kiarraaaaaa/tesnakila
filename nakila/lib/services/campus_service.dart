import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/campus_model.dart';

class CampusService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// ADD CAMPUS
  Future<void> addCampus(
    CampusModel campus,
  ) async {
    await _firestore
        .collection("campuses")
        .doc(campus.id)
        .set(
          campus.toMap(),
        );
  }

  /// GET ALL CAMPUSES
  Stream<List<CampusModel>>
      getCampuses() {
    return _firestore
        .collection("campuses")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map(
            (doc) =>
                CampusModel.fromMap(
              doc.data(),
            ),
          )
          .toList();
    });
  }

  /// GET ONE CAMPUS
  Future<CampusModel?> getCampus(
    String id,
  ) async {
    final doc =
        await _firestore
            .collection("campuses")
            .doc(id)
            .get();

    if (!doc.exists) {
      return null;
    }

    return CampusModel.fromMap(
      doc.data()!,
    );
  }

  /// UPDATE CAMPUS
  Future<void> updateCampus(
    CampusModel campus,
  ) async {
    await _firestore
        .collection("campuses")
        .doc(campus.id)
        .update(
          campus.toMap(),
        );
  }

  /// DELETE CAMPUS
  Future<void> deleteCampus(
    String id,
  ) async {
    await _firestore
        .collection("campuses")
        .doc(id)
        .delete();
  }
}