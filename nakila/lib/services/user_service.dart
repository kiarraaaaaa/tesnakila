import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  Stream<DocumentSnapshot<Map<String,dynamic>>>
      getCurrentUser() {

    return _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }
}