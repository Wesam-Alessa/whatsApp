import 'package:flutter/material.dart';
import 'package:whats_up/custom_ui/button_card.dart';
import 'package:whats_up/screens/home_page.dart';

import '../models/chat_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chatModel = [
    ChatModel(
        id: 1,
        name: 'wesam',
        icon: "assets/images/person.svg",
        time: '12:56 am',
        currentMessage: 'hello',
        isGroup: false),
    ChatModel(
        id: 2,
        name: 'Ahmad',
        icon: "assets/images/person.svg",
        time: '10:16 am',
        currentMessage: 'go to school',
        isGroup: false),
    // ChatModel(
    //     name: 'Best Friends',
    //     icon: "assets/images/groups.svg",
    //     time: '12:56 am',
    //     currentMessage: 'hello body',
    //     isGroup: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatModel.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  sourceChat = chatModel.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => HomePage(
                              chatModel: chatModel, sourceChat: sourceChat!)));
                },
                child: ButtonCard(
                    name: chatModel[index].name!, icon: Icons.person));
          }),
    );
  }
}
