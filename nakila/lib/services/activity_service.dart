import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addActivity({
    required String title,
    required String type,
  }) async {

    await _firestore
        .collection("activities")
        .add({

      "title": title,

      "type": type,

      "createdAt":
          FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<
      Map<String, dynamic>>>
      getActivities() {

    return _firestore
        .collection("activities")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .limit(30)
        .snapshots();
  }
}