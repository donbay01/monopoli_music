import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Slider1 extends StatelessWidget {
  const Slider1({Key? key}) : super(key: key);

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
                child: Image(image: AssetImage('assets/slider2.png'))),
          ),
          SizedBox(
            height: 20,
          ),
          GradientText(
            'Pulse of the planet, rhythm of life. Desthim takes you on the journey.',
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
