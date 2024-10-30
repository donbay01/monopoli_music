// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';

// import '../../constraint.dart';

class Slider2 extends StatelessWidget {
  const Slider2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
                child: Image(image: AssetImage('assets/slidertwo.png'))),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Listen to your\nfavorite artist non-stop',
            style: largeText(primaryWhite),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
