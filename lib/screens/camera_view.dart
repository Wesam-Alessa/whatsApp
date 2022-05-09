import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whats_up/utils/dimensions.dart';

class CameraViewPage extends StatelessWidget {
  final File image;
  final Function onImageSend;
  const CameraViewPage(
      {Key? key, required this.image, required this.onImageSend})
      : super(key: key);
  static TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.crop_rotate,
              size: Dimensions.iconSize24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions_outlined,
              size: Dimensions.iconSize24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.title,
              size: Dimensions.iconSize24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              size: Dimensions.iconSize24,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        child: Stack(
          children: [
            SizedBox(
              width: Dimensions.screenWidth,
              height: Dimensions.screenHeight - 150,
              child: Image.file(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Dimensions.screenWidth,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: _controller,
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.font17),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add Caption....',
                    hintStyle: TextStyle(
                        color: Colors.white, fontSize: Dimensions.font16),
                    prefixIcon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                    suffixIcon: InkWell(
                      onTap: () => onImageSend(image, _controller.text.trim()),
                      child: CircleAvatar(
                        radius: Dimensions.radius25,
                        backgroundColor: Colors.tealAccent[700],
                        child: Icon(
                          Icons.check,
                          size: Dimensions.iconSize24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
