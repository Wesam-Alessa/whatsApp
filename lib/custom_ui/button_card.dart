import 'package:flutter/material.dart';
 import 'package:whats_up/utils/dimensions.dart';

class ButtonCard extends StatelessWidget {
  final String name;
  final IconData icon;
  const ButtonCard({Key? key,required this.name,required this.icon }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF25D366),
          radius: Dimensions.radius30,
          child:Icon(icon,color: Colors.white,)
        ),
        title: Text(
           name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: Dimensions.font18),
        ),

      ),
    );
  }
}
