import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:tutor_matchup/widgets/custom_button.dart';

class TutorScheduleScreen extends StatefulWidget {
  const TutorScheduleScreen({Key? key}) : super(key: key);

  @override
  State<TutorScheduleScreen> createState() => _TutorScheduleScreenState();
}

class _TutorScheduleScreenState extends State<TutorScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final TextEditingController _subjectController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save the class to Firebase Firestore
  Future<void> _saveClass() async {
    if (_subjectController.text.isEmpty || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all details!'),
        ),
      );
      return;
    }

    final classData = {
      "date": _selectedDate.toIso8601String(),
      "time": "${_selectedTime!.hour}:${_selectedTime!.minute}",
      "subject": _subjectController.text,
      "createdAt": FieldValue.serverTimestamp(),
    };

    try {
      await _firestore.collection('tutor_classes').add(classData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Class saved successfully!'),
        ),
      );

      // Clear fields after saving
      _subjectController.clear();
      setState(() {
        _selectedTime = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save class: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidget(
              text: 'Select Date',
              fontSize: 16,
              textColor: midnightBlueColor,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
            // TableCalendar(
            //   firstDay: DateTime(2020),
            //   lastDay: DateTime(2100),
            //   focusedDay: _selectedDate,
            //   selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            //   onDaySelected: (selectedDay, focusedDay) {
            //     setState(() {
            //       _selectedDate = selectedDay;
            //     });
            //   },
            //   calendarStyle: const CalendarStyle(
            //     selectedDecoration: BoxDecoration(
            //       color: lightBlueColor,
            //       shape: BoxShape.circle,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            const CustomTextWidget(
              text: 'Select Time',
              fontSize: 16,
              textColor: midnightBlueColor,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                DatePicker.showTimePicker(
                  context,
                  showSecondsColumn: false,
                  onConfirm: (dateTime) {
                    setState(() {
                      _selectedTime = TimeOfDay(
                          hour: dateTime.hour, minute: dateTime.minute);
                    });
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: coolGrayColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _selectedTime == null
                      ? 'Tap to select time'
                      : '${_selectedTime!.hour}:${_selectedTime!.minute}',
                  style: const TextStyle(color: blackColor, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CustomTextWidget(
              text: 'Enter Subject',
              fontSize: 16,
              textColor: midnightBlueColor,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                hintText: 'Enter the subject',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'Save Class',
              onTap: _saveClass,
            ),
          ],
        ),
      ),
    );
  }

  isSameDay(DateTime selectedDate, day) {}
}

class TableCalendar {}

class CalendarStyle {
  const CalendarStyle();
}

class DatePicker {
  static void showTimePicker(BuildContext context,
      {required bool showSecondsColumn,
      required Null Function(dynamic dateTime) onConfirm}) {}
}
