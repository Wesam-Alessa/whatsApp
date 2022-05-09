import 'package:flutter/material.dart';
import 'package:whats_up/utils/dimensions.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: Dimensions.radius25,
            backgroundColor: Colors.white,
            backgroundImage: const AssetImage("assets/images/1.jpg"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: Dimensions.radius10,
              backgroundColor: Colors.greenAccent[700],
              child: Icon(
                Icons.add,
                size: Dimensions.iconSize16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      title: const Text(
        "My Status",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        "Tap to add status update",
        style: TextStyle(fontSize: Dimensions.font13, color: Colors.grey[900]),
      ),
    );
  }
}
