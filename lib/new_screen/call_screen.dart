import 'package:flutter/material.dart';
import 'package:whats_up/utils/dimensions.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          callCard(Icons.call_made, "Wesam", "July 18, 18:56", Colors.green,
              "assets/images/1.jpg"),
          callCard(Icons.call_missed, "Ali dev", "July 22, 10:06", Colors.red,
              "assets/images/2.jpg"),
          callCard(Icons.call_missed, "khaled", "July 11, 16:39", Colors.red,
              "assets/images/3.jpg"),
          callCard(Icons.call_made, "Wesam", "July 18, 18:56", Colors.green,
              "assets/images/1.jpg"),
        ],
      ),
    );
  }

  Widget callCard(
    IconData icon,
    String name,
    String time,
    Color iconColor,
    String img,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: Dimensions.height10 / 20),
      child: ListTile(
        leading: CircleAvatar(
          radius: Dimensions.radius25,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(img),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: Dimensions.iconSize16,
            ),
            const SizedBox(width: 6),
            Text(
              time,
              style: TextStyle(fontSize: Dimensions.font13),
            ),
          ],
        ),
        trailing: Icon(
          Icons.call,
          color: Colors.teal,
          size: Dimensions.iconSize24,
        ),
      ),
    );
  }
}
