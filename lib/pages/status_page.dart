import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:whats_up/custom_ui/status_page/head_own_status.dart';
import 'package:whats_up/custom_ui/status_page/other_status.dart';
import 'package:whats_up/utils/dimensions.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: Dimensions.height45,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blueGrey[100],
              elevation: 8,
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10),
            const HeadOwnStatus(),
            label("Recent updates"),
            const OtherStatus(
              name: 'Ahmead ali',
              time: "01:18",
              image: "assets/images/3.jpg",
              isSeen: false,
              statusNum: 1,
            ),
            const OtherStatus(
              name: 'mahmod amr',
              time: "10:52",
              image: "assets/images/2.jpg",
              isSeen: false,
              statusNum: 2,
            ),
            const OtherStatus(
              name: 'khaled wesam',
              time: "06:36",
              image: "assets/images/1.jpg",
              isSeen: false,
              statusNum: 3,
            ),
            const SizedBox(height: 10),
            label("Viewed updates"),
            const OtherStatus(
              name: 'Ahmead ali',
              time: "01:18",
              image: "assets/images/3.jpg",
              isSeen: true,
              statusNum: 1,
            ),
            const OtherStatus(
              name: 'mahmod amr',
              time: "10:52",
              image: "assets/images/2.jpg",
              isSeen: true,
              statusNum: 3,
            ),
            const OtherStatus(
              name: 'khaled wesam',
              time: "06:36",
              image: "assets/images/1.jpg",
              isSeen: true,
              statusNum: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: Dimensions.height20 + 5,
      color: Colors.grey[300],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
      child: Text(
        labelName,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font13),
      ),
    );
  }
}
