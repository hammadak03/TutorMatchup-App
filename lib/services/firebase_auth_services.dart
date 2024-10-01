import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    required String userType, // 'tutor' or 'student'
    String? phoneNo,
    String? education,
    String? availability,
    String? experience,
    String? subjects,
    String? institute,
    String? year,
    String? learningFormat,
    String? preferredDays,
    String? preferredTime,
    String? resume,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Save the common user data
        final Map<String, Object> userData = {
          'uid': user.uid,
          'email': email,
          'name': name,
          'userType': userType,
          'createdAt': FieldValue.serverTimestamp(),
        };

        // Save to specific collection
        if (userType == 'tutor') {
          await _firestore.collection('tutors').doc(user.uid).set({
            ...userData,
            'phoneNo': phoneNo,
            'education': education,
            'availability': availability,
            'experience': experience,
            'subjects': subjects,
            'resume': resume,
          });
        } else if (userType == 'student') {
          await _firestore.collection('students').doc(user.uid).set({
            ...userData,
            'institute': institute,
            'year': year,
            'learningFormat': learningFormat,
            'preferredDays': preferredDays,
            'preferredTime': preferredTime,
            'resume': resume,
          });
        }
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Reset password method
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Login method
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

  // Sign out method
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Get current user method
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Fetch user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }
}
