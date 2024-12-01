import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:monopoli/monopoli.dart';
import 'package:monopoli/screens/onboard/getStarted.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:zap_sizer/main.dart';
import '../../../theme/colors.dart';
import '../../components/onboarding_carousel/carousel.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onboarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          // reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideInDown(
                from: 90.h,
                delay: const Duration(milliseconds: 100),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Image(
                    image: AssetImage('assets/launchLogo.png'),
                  ),
                ),
              ),
              SlideInRight(
                delay: const Duration(milliseconds: 200),
                child: Carousel()
              ),
              const SizedBox(
                height: 60,
              ),
              SlideInUp(
                from: 100.h,
                delay: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GetStarted(),
                      ),
                    );
                  },
                  child: Text(
                    'Get Started',
                    style: mediumBold(primaryBlack),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 130),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: purple, width: 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
