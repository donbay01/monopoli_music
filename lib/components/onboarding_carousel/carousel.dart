import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:monopoli/components/onboarding_carousel/slider/slider_four.dart';
import 'package:monopoli/components/onboarding_carousel/slider/slider_one.dart';
import 'package:monopoli/components/onboarding_carousel/slider/slider_three.dart';
import 'package:monopoli/components/onboarding_carousel/slider/slider_two.dart';
import 'package:monopoli/theme/colors.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return FlutterCarousel(
      options: FlutterCarouselOptions(
        height: size.height / 2.2,
        showIndicator: false,
        slideIndicator: CircularSlideIndicator(),
        viewportFraction: 1,
        autoPlay: true,
      ),
      items: const [
        Slider1(),
        Slider2(),
      ],
    );
  }
}
