import 'package:flutter/material.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import '../models/message_model.dart';
import 'package:tutor_matchup/routes/routes.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        backgroundColor: whiteColor,
        centerTitle: true,
        title: const CustomTextWidget(
          text: 'Inbox',
          textColor: lightBlueColor,
        ),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final Message chat = chats[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.chat,
                arguments: chat.sender, // User object passed as arguments
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            spreadRadius: 2),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        chat.sender.imageUrl,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(
                              text: chat.sender.name,
                              textColor: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            CustomTextWidget(
                              text: chat.time,
                              textColor: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            chat.text,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
