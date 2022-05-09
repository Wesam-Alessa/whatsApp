import 'package:flutter/material.dart';
import 'package:whats_up/utils/dimensions.dart';

class ReplayMessageCard extends StatelessWidget {
  final String message;
    final String time;

  const ReplayMessageCard({Key? key, required this.message,required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Dimensions.screenWidth - 45,
        ),
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius10 / 2)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 60, top: 5, bottom: 22),
                child: Text(
                  message,
                  style: TextStyle(fontSize: Dimensions.font16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: Dimensions.font13,
                    color: Colors.grey[600],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
