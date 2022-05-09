 import 'package:flutter/material.dart';
import 'package:whats_up/custom_ui/avatar_card.dart';
import 'package:whats_up/custom_ui/contact_card.dart';
import 'package:whats_up/utils/app_colors.dart';
import 'package:whats_up/utils/dimensions.dart';

 import '../models/chat_model.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<CreateGroupPage> {

  List<ChatModel> contacts =[
    ChatModel(
        name: 'wesam',
        icon: "assets/images/person.svg",
        time: '12:56 am',
        status: 'Flutter Developer',
        isGroup: false
    ),
    ChatModel(
        name: 'Ahmad',
        icon: "assets/images/person.svg",
        time: '10:16 am',
        status: 'Full stack developer',
        isGroup: false
    ),
    ChatModel(
        name: 'wesam',
        icon: "assets/images/person.svg",
        time: '12:56 am',
        status: 'Flutter Developer',
        isGroup: false
    ),
    ChatModel(
        name: 'Ahmad',
        icon: "assets/images/person.svg",
        time: '10:16 am',
        status: 'Full stack developer',
        isGroup: false
    ),
    ChatModel(
        name: 'khaled',
        icon: "assets/images/person.svg",
        time: '12:56 am',
        status: 'team leader',
        isGroup: true
    ),
  ];
  List<ChatModel> groupMember =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whatsUpPrimaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Group',
              style: TextStyle(
                  fontSize: Dimensions.font18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Add Participants',
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
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length ,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: (){
                    if(contacts[index].select==false){
                      setState(() {
                        contacts[index].select=true;
                        groupMember.add(contacts[index]);
                      });
                    }else{
                      setState(() {
                        contacts[index].select = false;
                        groupMember.remove(contacts[index]);
                      });
                    }
                  },
                  child: ContactCard(contact:contacts[index]));
            },
          ),
          if(groupMember.isNotEmpty)
            Column(
            children: [
              Container(
                height: Dimensions.screenHeight/10,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: contacts.length,
                  itemBuilder: (context, index){
                    if(contacts[index].select){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            groupMember.remove(contacts[index]);
                            contacts[index].select = false;
                          });
                        },
                        child: AvatarCard(
                            name: contacts[index].name!,
                            img:  contacts[index].icon!,
                            size: Dimensions.radius25),
                      );
                    }else{
                      return Container();
                    }
                  }),
                ),
              const Divider(thickness: 1,),

            ],
          )
        ],
      ),
    );
  }
}
