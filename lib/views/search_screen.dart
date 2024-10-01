import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import 'package:tutor_matchup/widgets/near_tutor_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Search Tutors',
          textColor: lightBlueColor,
        ),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: searchController,
            hintText: 'Search tutor...',
            prefixIcon: const Icon(Icons.search),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return NearTutorCard(
                    name: 'Tutor Name',
                    reviews: '4.5',
                    location: 'Hyderabad',
                    onPressed: () {},
                    opensAt: '4:00 PM',
                    subjects: 'Mathematics');
              },
            ),
          ),
        ],
      ),
    );
  }
}
