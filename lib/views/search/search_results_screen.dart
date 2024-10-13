import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_field.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: 'All Tutors',
          fontWeight: FontWeight.w500,
          textColor: lightBlueColor,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              hintText: 'Search Tutors...',
              prefixIcon: const Icon(Icons.search),
              controller: searchController,
            ),
          ),
          // Category buttons (General, Cardiologist, etc.)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryButton('All'),
                _buildCategoryButton('Math'),
                _buildCategoryButton('Science'),
                _buildCategoryButton('English'),
                _buildCategoryButton('Physics'),
                _buildCategoryButton('Chemistry'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // List of tutors
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Change to the dynamic count of tutors
              itemBuilder: (context, index) {
                return _buildTutorCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: CustomTextWidget(
          text: label,
          textColor: lightBlueColor,
        ),
      ),
    );
  }

  Widget _buildTutorCard() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: CustomTextWidget(
          text: 'Dr. David Patel',
          textColor: blackColor,
          fontWeight: FontWeight.w500,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: 'Mathematics',
              textColor: coolGrayColor,
              fontSize: 14,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: bluishGreyColor,
                ),
                SizedBox(width: 4),
                CustomTextWidget(
                  text: 'MUET, Jamshoro',
                  textColor: coolGrayColor,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 14,
                  color: bluishGreyColor,
                ),
                SizedBox(width: 4),
                CustomTextWidget(
                  text: '4.6 (127 Reviews)',
                  textColor: coolGrayColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
