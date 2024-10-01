class Tutor {
  final String uid;
  final String name;
  final String email;
  final String phoneNo;
  final String education;
  final String availability;
  final String experience;
  final String subjects;
  final String resume;

  Tutor({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.education,
    required this.availability,
    required this.experience,
    required this.subjects,
    required this.resume,
  });

  // Convert tutor object to map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'education': education,
      'availability': availability,
      'experience': experience,
      'subjects': subjects,
      'resume': resume,
    };
  }

  // Create tutor object from Firestore document snapshot
  factory Tutor.fromDocument(Map<String, dynamic> doc) {
    return Tutor(
      uid: doc['uid'],
      name: doc['name'],
      email: doc['email'],
      phoneNo: doc['phoneNo'],
      education: doc['education'],
      availability: doc['availability'],
      experience: doc['experience'],
      subjects: doc['subjects'],
      resume: doc['resume'],
    );
  }
}
