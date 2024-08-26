import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> tutorSignUp(
      String email,
      String password,
      String name,
      String phoneNo,
      String education,
      String availability,
      String experience,
      String subjects,
      String resume) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Save the additional user information to Firestore
        await _firestore.collection('tutor').doc(user.uid).set({
          'email': email,
          'name': name,
          'createdAt': FieldValue.serverTimestamp(),
          'phoneNo': phoneNo,
          'education': education,
          'availability': availability,
          'experience': experience,
          'subjects': subjects,
          'resume': resume,
        });
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> studentSignUp(
      String email,
      String password,
      String name,
      String institute,
      String year,
      String learningFormat,
      String preferredDays,
      String preferredTime,
      String resume) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Save the additional user information to Firestore
        await _firestore.collection('student').doc(user.uid).set({
          'email': email,
          'name': name,
          'createdAt': FieldValue.serverTimestamp(),
          'institute': institute,
          'year': year,
          'learningFormat': learningFormat,
          'experience': preferredDays,
          'preferredTime': preferredTime,
        });
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }
}
