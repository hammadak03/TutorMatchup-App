import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';

class LectureCard extends StatelessWidget {
  final String name;
  final String availableDays;
  final String availableTime;
  final String subjects;
  final VoidCallback? onTap;

  const LectureCard({
    Key? key,
    required this.name,
    required this.availableDays,
    required this.availableTime,
    required this.subjects,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              'Days: $availableDays',
              style: const TextStyle(
                color: coolGrayColor,
                fontSize: 14,
              ),
            ),
            Text(
              'Time: $availableTime',
              style: const TextStyle(
                color: coolGrayColor,
                fontSize: 14,
              ),
            ),
            Text(
              'Subjects: $subjects',
              style: const TextStyle(
                color: coolGrayColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: lightBlueColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
