import 'package:flutter/material.dart';
import 'package:monopoli/components/onboarding_carousel/slider/slider_one.dart';
import 'package:monopoli/components/onboarding_carousel/slider/slider_two.dart';
import 'package:monopoli/theme/colors.dart';


class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final int _numPages = 2;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.45,
              width: size.width,
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const [
                  Slider1(),
                  Slider2(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _buildPageIndicator(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      duration: const Duration(milliseconds: 250),
      height: 4.0,
      width: isActive ? 20.0 : 15.0,
      decoration: BoxDecoration(
        color: isActive ? purple : primaryWhite,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
