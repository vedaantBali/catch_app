import 'package:catch_app/model/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserId _userId(User user) {
    return user != null ? UserId(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
          email: email,
          password: password);

      User user = userCredential.user;
      return _userId(user);

    } catch(err) {
      print(err);

    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: email,
          password: password);

      User user = userCredential.user;
      return _userId(user);

    }catch(err) {

    }
  }

  Future resetPassword(String email) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch(err) {

    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch(err) {

    }
  }

}