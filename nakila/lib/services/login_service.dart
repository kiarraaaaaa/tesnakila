import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {

    try {

      UserCredential credential =
          await _auth
              .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot doc =
          await _firestore
              .collection("users")
              .doc(
                credential.user!.uid,
              )
              .get();

      if (!doc.exists) {
        return null;
      }

      return doc.data()
          as Map<String, dynamic>;

    } on FirebaseAuthException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}