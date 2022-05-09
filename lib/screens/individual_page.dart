import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_up/custom_ui/file_card/own_file_card.dart';
import 'package:whats_up/custom_ui/own_message_card.dart';
import 'package:whats_up/custom_ui/replay_message_card.dart';
import 'package:whats_up/models/message_model.dart';
import 'package:whats_up/screens/camera_screen.dart';
import 'package:whats_up/screens/camera_view.dart';
import 'package:whats_up/utils/app_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import '../custom_ui/file_card/replay_file_card.dart';
import '../models/chat_model.dart';
import '../utils/dimensions.dart';

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;

  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourceChat})
      : super(key: key);

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  //the focusNode in controller for close and open keyboard
  FocusNode focusNode = FocusNode();
  bool showEmoji = false;
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    socket.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.8.114:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) {
      print("CONNECTED");
      socket.on("message", (msg) {
        print(msg);
        setMessage(
          "destination",
          msg["message"],
          msg["path"],
        );
      });
    });

    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path
    });
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16),
        path: path);
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  void onImageSend(File image, String message) async {
    print("HEY THERE WORKING $message");
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.8.114:5000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", image.path));
    request.headers.addAll({"Content-type": "multipart/from-data"});
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(response.statusCode);
    print(data['path']);
    setMessage("source", message, image.path);
    socket.emit("message", {
      "message": message,
      "sourceId": widget.sourceChat.id,
      "targetId": widget.chatModel.id,
      "path": data['path']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.whatsUpPrimaryColor,
          leadingWidth: Dimensions.width15 * 4,
          titleSpacing: 0,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: Dimensions.iconSize24,
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: Dimensions.radius20,
                backgroundColor: Colors.blueGrey,
                child: SvgPicture.asset(
                  widget.chatModel.isGroup
                      ? 'assets/images/groups.svg'
                      : 'assets/images/person.svg',
                  color: Colors.white,
                  height: Dimensions.height15 * 2.5,
                  width: Dimensions.width15 * 2.5,
                ),
              ),
            ],
          ),
          title: GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatModel.name!,
                  style: TextStyle(
                      fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "last seen today at 12:38 am",
                  style: TextStyle(
                    fontSize: Dimensions.font26 / 2,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(onTap: () {}, child: const Icon(Icons.videocam)),
            const SizedBox(width: 12),
            GestureDetector(onTap: () {}, child: const Icon(Icons.call)),
            PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    child: Text('View contact'),
                    value: 'View contact',
                  ),
                  PopupMenuItem(
                    child: Text('Media, links, and docs'),
                    value: 'Media, links, and docs',
                  ),
                  PopupMenuItem(
                    child: Text('Whatsapp web'),
                    value: 'Whatsapp web',
                  ),
                  PopupMenuItem(
                    child: Text('Search'),
                    value: 'Search',
                  ),
                  PopupMenuItem(
                    child: Text('Mute Notification'),
                    value: 'Mute Notification',
                  ),
                  PopupMenuItem(
                    child: Text('Wallpaper'),
                    value: 'Wallpaper',
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/whatsapp_Back.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: WillPopScope(
              onWillPop: () {
                if (showEmoji) {
                  setState(() {
                    showEmoji = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    //height: Dimensions.screenHeight - (Dimensions.height20 * 7),
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return SizedBox(
                            height: Dimensions.height10 * 7,
                          );
                        }
                        if (messages[index].type == "source") {
                          if (messages[index].path.isNotEmpty) {
                            return OwnFileCard(
                              image: File(
                                messages[index].path,
                              ),
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        } else {
                          if (messages[index].path.isNotEmpty) {
                            return ReplayFileCard(
                              image: File(
                                messages[index].path,
                              ),
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return ReplayMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        }
                      },
                    ),
                    // child: ListView(children: [
                    //   OwnFileCard(),
                    //   ReplayFileCard(),
                    // ]),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: Dimensions.height10 * 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 55,
                                child: Card(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20)),
                                  child: TextFormField(
                                    controller: _textEditingController,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type a message',
                                      contentPadding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      prefixIcon: IconButton(
                                        icon: showEmoji
                                            ? const Icon(
                                                Icons.keyboard,
                                                color: AppColors
                                                    .whatsUpPrimaryColor,
                                              )
                                            : const Icon(
                                                Icons.emoji_emotions_outlined,
                                                color: AppColors
                                                    .whatsUpPrimaryColor,
                                              ),
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            showEmoji = !showEmoji;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.attach_file,
                                              color:
                                                  AppColors.whatsUpPrimaryColor,
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (builder) =>
                                                      urlsWidget());
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              color:
                                                  AppColors.whatsUpPrimaryColor,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                popTime = 2;
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      CameraScreen(
                                                    onImageSend: onImageSend,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColors.whatsUpAccentColor,
                                  child: IconButton(
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            _textEditingController.text,
                                            widget.sourceChat.id!,
                                            widget.chatModel.id!,
                                            "");
                                        _textEditingController.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (showEmoji)
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Expanded(
                                child: emojiSelect(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        // Do something when emoji is tapped
        setState(() {
          _textEditingController.text += emoji.emoji;
        });
      },
      onBackspacePressed: () {
        // Backspace-Button tapped logic
        // Remove this line to also remove the button in the UI
      },
      config: Config(
          columns: 7,
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          progressIndicatorColor: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecentsText: "No Recents",
          noRecentsStyle: const TextStyle(fontSize: 20, color: Colors.black26),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL),
    );
  }

  Widget urlsWidget() {
    return SizedBox(
      height: Dimensions.height45 * 6,
      width: double.maxFinite,
      child: Card(
        margin: EdgeInsets.all(Dimensions.width10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconCreation(
                    icon: Icons.insert_drive_file,
                    text: 'Document',
                    backgroundColor: Colors.indigo,
                    onTap: () {}),
                iconCreation(
                    icon: Icons.camera_alt,
                    text: 'Camera',
                    backgroundColor: Colors.pink,
                    onTap: () {
                      setState(() {
                        popTime = 3;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CameraScreen(
                                    onImageSend: onImageSend,
                                  )));
                    }),
                iconCreation(
                  icon: Icons.insert_photo,
                  text: 'Gallery',
                  backgroundColor: Colors.purple,
                  onTap: () async {
                    setState(() {
                      popTime = 2;
                    });
                    file = await _picker.pickImage(source: ImageSource.gallery);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CameraViewPage(
                                  image: File(file!.path),
                                  onImageSend: onImageSend,
                                )));
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconCreation(
                    icon: Icons.headset_mic_outlined,
                    text: 'Audio',
                    backgroundColor: Colors.orange,
                    onTap: () {}),
                iconCreation(
                    icon: Icons.person,
                    text: 'Contact',
                    backgroundColor: Colors.green,
                    onTap: () {}),
                iconCreation(
                    icon: Icons.location_pin,
                    text: 'Location',
                    backgroundColor: Colors.blue,
                    onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconCreation(
      {required IconData icon,
      required String text,
      required Color backgroundColor,
      required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          CircleAvatar(
            radius: Dimensions.radius30,
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              size: Dimensions.iconSize24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}
