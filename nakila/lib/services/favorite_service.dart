import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> toggleFavorite({
    required String uid,
    required String campusId,
  }) async {

    DocumentReference userRef =
        _firestore
            .collection("users")
            .doc(uid);

    DocumentSnapshot snapshot =
        await userRef.get();

    List favorites =
        snapshot["favorites"] ?? [];

    if (favorites.contains(campusId)) {

      favorites.remove(campusId);

    } else {

      favorites.add(campusId);

    }

    await userRef.update({
      "favorites": favorites,
    });
  }

  Stream<List<String>> getFavorites(
    String uid,
  ) {

    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snapshot) {

      if (!snapshot.exists) {
        return [];
      }

      return List<String>.from(
        snapshot["favorites"] ?? [],
      );
    });
  }
}