import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/dimensions.dart';

class AvatarCard extends StatelessWidget {
  final String name;
  final String img;
  final double size;
  const AvatarCard({Key? key,required this.name,required this.img,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey[300],
                radius: size,
                child: SvgPicture.asset(
                  img,
                  height: Dimensions.height30,
                  width: Dimensions.width30,
                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: Dimensions.radius10,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: Dimensions.iconSize16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: TextStyle(fontSize: Dimensions.font20/2),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
