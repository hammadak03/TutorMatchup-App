class Student {
  final String uid;
  final String name;
  final String email;
  final String institute;
  final String year;
  final String learningFormat;
  final String preferredDays;
  final String preferredTime;
  final String resume;

  Student({
    required this.uid,
    required this.name,
    required this.email,
    required this.institute,
    required this.year,
    required this.learningFormat,
    required this.preferredDays,
    required this.preferredTime,
    required this.resume,
  });

  // Convert student object to map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'institute': institute,
      'year': year,
      'learningFormat': learningFormat,
      'preferredDays': preferredDays,
      'preferredTime': preferredTime,
      'resume': resume,
    };
  }

  // Create student object from Firestore document snapshot
  factory Student.fromDocument(Map<String, dynamic> doc) {
    return Student(
      uid: doc['uid'],
      name: doc['name'],
      email: doc['email'],
      institute: doc['institute'],
      year: doc['year'],
      learningFormat: doc['learningFormat'],
      preferredDays: doc['preferredDays'],
      preferredTime: doc['preferredTime'],
      resume: doc['resume'],
    );
  }
}
