import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_matchup/routes/routes.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:tutor_matchup/widgets/near_tutor_card.dart';
import 'package:tutor_matchup/widgets/upcomming_lecture_card.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {

  String? _userName; // Variable to store user name

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the widget initializes
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            _userName = userDoc.data()?['name'] as String?;
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle error, e.g., show an error message
    }
  }

  // Function to calculate distance using Haversine formula
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // Distance in kilometers
  }

  // Function to fetch tutors from Firebase and filter by distance
  Future<List<DocumentSnapshot>> fetchNearbyTutors(
      double userLatitude, double userLongitude) async {
    final tutorsCollection = FirebaseFirestore.instance.collection('tutors');
    final querySnapshot = await tutorsCollection.get();
    final tutors = querySnapshot.docs;

    // Filter tutors based on distance
    final nearbyTutors = tutors.where((tutor) {
      final tutorLatitude = tutor['latitude'] as double?;
      final tutorLongitude = tutor['longitude'] as double?;

      if (tutorLatitude != null && tutorLongitude != null) {
        final distance = calculateDistance(
            userLatitude, userLongitude, tutorLatitude, tutorLongitude);
        return distance <= 10; // Within 10km radius
      } else {
        return false; // Exclude tutors with missing location data
      }
    }).toList();

    return nearbyTutors;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: 'Hello, ',
                        fontSize: 16,
                        textColor: Color(0xFF8696BB),
                      ),
                      CustomTextWidget(
                        text: 'Hi Sana Ali',
                        fontWeight: FontWeight.w700,
                        textColor: blackColor,
                        fontSize: 20,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                ],
              ),
            ), //appba4/intro
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: fetchNearbyTutors(
                    37.42796133580664, -122.085749655962), // Replace with user's location
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final nearbyTutors = snapshot.data!;
                    return ListView.builder(
                      itemCount: nearbyTutors.length,
                      itemBuilder: (context, index) {
                        final tutor =
                        nearbyTutors[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: NearTutorCard(
                            name: tutor['name'] ?? 'Unknown Name',
                            reviews: '4.8 (120 Reviews)', // Replace with actual reviews
                            location: '1.8 Km', // Replace with calculated distance
                            opensAt: 'Open at 4:00pm', // Replace with tutor's availability
                            subjects: tutor['subjects'] ?? 'Unknown Subjects',
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.tutorDetails);
                            },
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Search tutor or Subjects',
              prefixIcon: const Icon(Icons.search),
              onTap: () {
                Navigator.pushNamed(context, Routes.searchResults);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                QuickAccessButton(
                  icon: const Icon(Icons.note_alt_outlined),
                  text: 'Assignment',
                  onPressed: () {},
                ),
                QuickAccessButton(
                  icon: const Icon(Icons.person_add_alt_1),
                  text: 'Tutors',
                  onPressed: () {},
                ),
                QuickAccessButton(
                  icon: const Icon(Icons.menu_book_outlined),
                  text: 'Subjects',
                  onPressed: () {},
                ),
                QuickAccessButton(
                  icon: const Icon(Icons.house_rounded),
                  text: 'Hybrid',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: CustomTextWidget(
                  text: 'Near Tutors',
                  fontWeight: FontWeight.w700,
                  textColor: midnightBlueColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: fetchNearbyTutors(
                    37.42796133580664, -122.085749655962), // Replace with user's location
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final nearbyTutors = snapshot.data!;
                    return ListView.builder(
                      itemCount: nearbyTutors.length,
                      itemBuilder: (context, index) {
                        final tutor = nearbyTutors[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: NearTutorCard(
                            name: tutor['name'] ?? 'Unknown Name',
                            reviews: '4.8 (120 Reviews)', // Replace with actual reviews
                            location: '1.8 Km', // Replace with calculated distance
                            opensAt: 'Open at 4:00pm', // Replace with tutor's availability
                            subjects: tutor['subjects'] ?? 'Unknown Subjects',
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.tutorDetails);
                            },
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickAccessButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String text;
  const QuickAccessButton(
      {required this.onPressed,
      required this.icon,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: icon,
          color: lightBlueColor,
          onPressed: onPressed,
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextWidget(
          text: text,
          textColor: coolGrayColor,
        )
      ],
    );
  }
}
