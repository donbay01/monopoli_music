import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';

class Slider3 extends StatelessWidget {
  const Slider3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
                child: Image(image: AssetImage('assets/disc.png'))),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Over 1000+\nMusic for the soul',
            style: largeText(primaryWhite),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
