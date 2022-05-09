import 'package:flutter/material.dart';
import 'package:whats_up/custom_ui/custom_card.dart';
import 'package:whats_up/models/chat_model.dart';
import 'package:whats_up/screens/select_contact.dart';
import 'package:whats_up/utils/app_colors.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatModel;
  final ChatModel sourceChat;

  const ChatPage({Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // List<ChatModel>chats=[
  //   ChatModel(
  //       name: 'wesam',
  //       icon: "assets/images/person.svg",
  //       time: '12:56 am',
  //     currentMessage: 'hello',
  //     isGroup: false
  //   ),
  //   ChatModel(
  //       name: 'Ahmad',
  //       icon: "assets/images/person.svg",
  //       time: '10:16 am',
  //       currentMessage: 'go to school',
  //       isGroup: false
  //   ),
  //   ChatModel(
  //       name: 'Best Friends',
  //       icon: "assets/images/groups.svg",
  //       time: '12:56 am',
  //       currentMessage: 'hello body',
  //       isGroup: true
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whatsUpAccentColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const SelectContactPage()));
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
          itemCount: widget.chatModel.length,
          itemBuilder: (context, index) {
            return CustomCard(
              chatModel: widget.chatModel[index],
              sourceChat: widget.sourceChat,
            );
          }),
    );
  }
}
