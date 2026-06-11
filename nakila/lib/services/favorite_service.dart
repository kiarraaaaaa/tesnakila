import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  Future<void> toggleFavorite(
    String campusId,
  ) async {

    final uid =
        _auth.currentUser!.uid;

    final query =
        await _firestore
            .collection("favorites")
            .where(
              "userId",
              isEqualTo: uid,
            )
            .where(
              "campusId",
              isEqualTo: campusId,
            )
            .get();

    if (query.docs.isNotEmpty) {

      await query.docs.first.reference
          .delete();

    } else {

      await _firestore
          .collection("favorites")
          .add({

        "userId": uid,
        "campusId": campusId,
        "createdAt":
            Timestamp.now(),
      });
    }
  }

  Stream<QuerySnapshot>
      getFavorites() {

    return _firestore
        .collection("favorites")
        .where(
          "userId",
          isEqualTo:
              _auth.currentUser!.uid,
        )
        .snapshots();
  }
}