import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:monopoli/monopoli.dart';
import 'package:monopoli/screens/onboard/getStarted.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:zap_sizer/main.dart';
import '../../../theme/colors.dart';

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
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideInDown(
                from: 90.h,
                delay: const Duration(milliseconds: 1000),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Image(
                    image: AssetImage('assets/appLogo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Pulse(
                delay: const Duration(milliseconds: 1300),
                child: Text(
                  'Music for the Soul.',
                  style: boldText(primaryWhite),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SlideInUp(
                from: 90.h,
                delay: const Duration(milliseconds: 1600),
                child: Text(
                  'Enjoy the best songs from your\nfavourite artists, Tailor your playlist\n to your taste.',
                  style: mediumSemiBold(primaryWhite),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SlideInUp(
                from: 100.h,
                delay: const Duration(milliseconds: 1900),
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
                    style: mediumBold(primaryWhite),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
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
