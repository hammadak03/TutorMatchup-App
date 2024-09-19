import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Unified sign-up method for both tutors and students
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
        // Save the common and additional user information to Firestore
        final Map<String, Object> userData = {
          'email': email,
          'name': name,
          'userType': userType,
          'createdAt': FieldValue.serverTimestamp(),
        };

        // Add tutor-specific fields if the user is a tutor
        if (userType == 'tutor') {
          if (phoneNo != null) userData['phoneNo'] = phoneNo;
          if (education != null) userData['education'] = education;
          if (availability != null) userData['availability'] = availability;
          if (experience != null) userData['experience'] = experience;
          if (subjects != null) userData['subjects'] = subjects;
          if (resume != null) userData['resume'] = resume;
        }

        // Add student-specific fields if the user is a student
        else if (userType == 'student') {
          if (institute != null) userData['institute'] = institute;
          if (year != null) userData['year'] = year;
          if (learningFormat != null)
            userData['learningFormat'] = learningFormat;
          if (preferredDays != null) userData['preferredDays'] = preferredDays;
          if (preferredTime != null) userData['preferredTime'] = preferredTime;
          if (resume != null) userData['resume'] = resume;
        }

        // Save the data in the 'users' collection
        await _firestore.collection('users').doc(user.uid).set(userData);
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
