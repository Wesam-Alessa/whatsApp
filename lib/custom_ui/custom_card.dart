import 'package:flutter/material.dart';
import 'package:whats_up/models/chat_model.dart';
import 'package:whats_up/screens/individual_page.dart';
import 'package:whats_up/utils/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;

  const CustomCard(
      {Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.height10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => IndividualPage(
                        chatModel: chatModel,
                        sourceChat: sourceChat,
                      )));
        },
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: Dimensions.radius30,
                backgroundColor: Colors.blueGrey,
                child: SvgPicture.asset(
                  chatModel.isGroup
                      ? 'assets/images/groups.svg'
                      : 'assets/images/person.svg',
                  color: Colors.white,
                  height: Dimensions.height15 * 2.5,
                  width: Dimensions.width15 * 2.5,
                ),
              ),
              title: Text(
                chatModel.name!,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Dimensions.font18),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.done_all,
                    size: Dimensions.iconSize16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    chatModel.currentMessage!,
                    style: TextStyle(fontSize: Dimensions.font16),
                  ),
                ],
              ),
              trailing: Text(chatModel.time!),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.7, right: Dimensions.width15),
              child: const Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
