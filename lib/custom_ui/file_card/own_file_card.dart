import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whats_up/utils/dimensions.dart';

class OwnFileCard extends StatelessWidget {
  final File image;
  final String message;
  final String time;
  const OwnFileCard(
      {Key? key,
      required this.image,
      required this.message,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width10 / 2,
            vertical: Dimensions.height10 / 2),
        child: Container(
          height: Dimensions.screenHeight / 2.15,
          width: Dimensions.screenWidth / 1.8,
          decoration: BoxDecoration(
            color: Colors.green[300],
            borderRadius: BorderRadius.circular(
              Dimensions.radius15,
            ),
          ),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(3),
            semanticContainer: true,
            color: Colors.teal[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius15,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.file(
                    image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                message.isNotEmpty
                    ? Container(
                        height: Dimensions.height45,
                        padding: EdgeInsets.only(
                            left: Dimensions.width15,
                            top: Dimensions.height15 / 2),
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
