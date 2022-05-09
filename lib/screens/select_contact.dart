import 'package:flutter/material.dart';
import 'package:whats_up/custom_ui/contact_card.dart';
import 'package:whats_up/screens/create_group.dart';
import 'package:whats_up/utils/app_colors.dart';
import 'package:whats_up/utils/dimensions.dart';

import '../custom_ui/button_card.dart';
import '../models/chat_model.dart';

class SelectContactPage extends StatefulWidget {
  const SelectContactPage({Key? key}) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  List<ChatModel> contacts = [
    ChatModel(
        name: 'wesam',
        icon: "assets/images/person.svg",
        time: '12:56 am',
        status: 'Flutter Developer',
        isGroup: false),
    ChatModel(
        name: 'Ahmad',
        icon: "assets/images/person.svg",
        time: '10:16 am',
        status: 'Full stack developer',
        isGroup: false),
    ChatModel(
        name: 'wesam',
        icon: "assets/images/person.svg",
        time: '12:56 am',
        status: 'Flutter Developer',
        isGroup: false),
    ChatModel(
        name: 'Ahmad',
        icon: "assets/images/person.svg",
        time: '10:16 am',
        status: 'Full stack developer',
        isGroup: false),
    ChatModel(
        name: 'khaled',
        icon: "assets/images/person.svg",
        time: '12:56 am',
        status: 'team leader',
        isGroup: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whatsUpPrimaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Contact',
              style: TextStyle(
                  fontSize: Dimensions.font18, fontWeight: FontWeight.bold),
            ),
            Text(
              '256 contact',
              style: TextStyle(
                fontSize: Dimensions.font14,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: Dimensions.iconSize24,
            ),
          ),
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    child: Text('Invite a Friend'),
                    value: 'Invite a Friend',
                  ),
                  PopupMenuItem(
                    child: Text('Contacts'),
                    value: 'Contacts',
                  ),
                  PopupMenuItem(
                    child: Text('Refresh'),
                    value: 'Refresh',
                  ),
                  PopupMenuItem(
                    child: Text('Help'),
                    value: 'Help',
                  ),
                ];
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CreateGroupPage()));
              },
              child: const ButtonCard(icon: Icons.group, name: 'New Group'),
            );
          } else if (index == 1) {
            return const ButtonCard(
                icon: Icons.person_add, name: 'New Contact');
          }
          return ContactCard(contact: contacts[index - 2]);
        },
      ),
    );
  }
}
