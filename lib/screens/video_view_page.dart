import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whats_up/utils/dimensions.dart';

class VideoViewPage extends StatefulWidget {
  final File video;

  const VideoViewPage({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _controller;
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          playing = true;
        });
      } else {
        setState(() {
          playing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    playing = false;
    super.dispose();
  }

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
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Dimensions.screenWidth,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
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
                      suffixIcon: CircleAvatar(
                        radius: Dimensions.radius25,
                        backgroundColor: Colors.tealAccent[700],
                        child: Icon(
                          Icons.check,
                          size: Dimensions.iconSize24,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundColor: Colors.black38,
                  child: playing
                      ? Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: Dimensions.iconSize24 * 2,
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: Dimensions.iconSize24 * 2,
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
