import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';

class PodcastHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child:Container(
              width: width * 0.3,
              child: Image(image: AssetImage('assets/hiphop.png'),fit: BoxFit.cover,)),),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who are the Big 3?',
                style: mediumSemiBold(primaryWhite),
              ),
              SizedBox(height: 8.0),
              Text(
                'Hosted by: MTV Base',
                style: mediumText(Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
