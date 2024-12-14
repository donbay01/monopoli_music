import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Slider3 extends StatelessWidget {
  const Slider3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                  child: Image(image: AssetImage('assets/disc.png'))),
            ),
            SizedBox(
              height: 20,
            ),
            GradientText(
              'Discover Africa’s soul and the world’s pulse one note at a time.',
              style: mediumSemiBold(primaryWhite),
              textAlign: TextAlign.center,
              colors: [
                purple,
                primaryWhite
              ],
            )
          ],
        ),
      ),
    );
  }
}
