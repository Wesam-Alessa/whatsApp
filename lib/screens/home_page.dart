import 'package:flutter/material.dart';
import 'package:whats_up/new_screen/call_screen.dart';
import 'package:whats_up/pages/status_page.dart';
import 'package:whats_up/screens/camera_screen.dart';
import 'package:whats_up/utils/app_colors.dart';

import '../models/chat_model.dart';
import '../pages/chat_page.dart';

class HomePage extends StatefulWidget {
  final List<ChatModel> chatModel;
  final ChatModel sourceChat;
  const HomePage({Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whatsUpPrimaryColor,
        title: const Text('Whats Up'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    child: Text('New group'),
                    value: 'New group',
                  ),
                  PopupMenuItem(
                    child: Text('New broadcast'),
                    value: 'New broadcast',
                  ),
                  PopupMenuItem(
                    child: Text('Whatsapp web'),
                    value: 'Whatsapp web',
                  ),
                  PopupMenuItem(
                    child: Text('Starred message'),
                    value: 'Starred message',
                  ),
                  PopupMenuItem(
                    child: Text('Settings'),
                    value: 'Settings',
                  ),
                ];
              }),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_enhance_outlined),
            ),
            Tab(
              text: 'CHATS',
            ),
            Tab(
              text: 'STATUS',
            ),
            Tab(
              text: 'CALLS',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraScreen(onImageSend: () {}),
          ChatPage(
            chatModel: widget.chatModel,
            sourceChat: widget.sourceChat,
          ),
          const StatusPage(),
          const CallScreen()
        ],
      ),
    );
  }
}
