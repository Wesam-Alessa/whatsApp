import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_up/models/chat_model.dart';
import 'package:whats_up/utils/dimensions.dart';

class ContactCard extends StatelessWidget {
  final ChatModel contact;
  const ContactCard({Key? key,required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: Dimensions.height45 + Dimensions.height10,
        width: Dimensions.screenWidth/(Dimensions.screenWidth/58),
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[300],
              radius: Dimensions.radius30,
              child: SvgPicture.asset(
                contact.isGroup ? "assets/images/groups.svg":'assets/images/person.svg',
                height: Dimensions.height30,
                width: Dimensions.width30,
                color: Colors.white,
              ),
            ),
            if(contact.select)
              Positioned(
              bottom: 2,
              right: 1,
              child: CircleAvatar(
                backgroundColor: Colors.teal,
                radius: Dimensions.radius10,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: Dimensions.iconSize16,
                ),
              ),
            ),
          ],
        ),
      ),
       title: Text(
         contact.name!,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: Dimensions.font16),
      ),
      subtitle: Text(
        contact.status!,
        style: TextStyle(fontSize: Dimensions.font26/2),
      ),
    );
  }
}
