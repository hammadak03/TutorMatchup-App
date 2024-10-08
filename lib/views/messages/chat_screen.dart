import 'package:flutter/material.dart';
import 'package:tutor_matchup/models/message_model.dart';
import 'package:tutor_matchup/utils/colors.dart';
import 'package:tutor_matchup/widgets/custom_text_widget.dart';
import '../../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _chatButtle(Message message, bool isMe) {
    if (isMe) {
      return Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.80),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: lightBlueColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: CustomTextWidget(
                text: message.text,
                textColor: whiteColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextWidget(
                text: message.time,
                textColor: Colors.black54,
                fontSize: 12,
              ),
              const SizedBox(
                width: 10,
              ),
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
                  radius: 15,
                  backgroundImage: NetworkImage(
                    message.sender.imageUrl,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: CustomTextWidget(
                    text: message.text,
                    textColor: Colors.black54,
                  ),
                ),
              ),
              Row(
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
                      radius: 15,
                      backgroundImage: NetworkImage(
                        message.sender.imageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomTextWidget(
                    text: message.time,
                    textColor: Colors.black54,
                    fontSize: 12,
                  )
                ],
              ),
            ],
          ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 60,
      color: whiteColor,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.photo,
              size: 25,
              color: lightBlueColor,
            ),
          ),
          const Expanded(
            child: TextField(
              decoration:
                  InputDecoration.collapsed(hintText: 'Send a message...'),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
              size: 25,
              color: lightBlueColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: CustomTextWidget(
          text: user.name,
          fontSize: 16,
          textColor: lightBlueColor,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final Message message = messages[index];
                final bool isMe = message.sender.id == currentUser.id;
                return _chatButtle(message, isMe);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
