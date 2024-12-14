// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';

// import '../../constraint.dart';

class Slider2 extends StatelessWidget {
  const Slider2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
                child: Image(image: AssetImage('assets/slider1.png'))),
          ),
          SizedBox(
            height: 20,
          ),
          GradientText(
            'Explore the sounds that connect us all, from village drums to global hits.',
            style: mediumSemiBold(primaryWhite),
            textAlign: TextAlign.center,
            colors: [
              purple,
              primaryWhite
            ],
          )
        ],
      ),
    );
  }
}
