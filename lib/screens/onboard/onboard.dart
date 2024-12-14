import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monopoli/providers/player.dart';
import 'package:monopoli/screens/auth/login.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:monopoli/monopoli.dart';
import 'package:monopoli/screens/onboard/getStarted.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:zap_sizer/main.dart';
import '../../../theme/colors.dart';
import '../../components/onboarding_carousel/carousel.dart';

class OnboardingCarousel extends ConsumerStatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  ConsumerState<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends ConsumerState<OnboardingCarousel> {
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
              SizedBox(
                height: 50,
              ),
              SlideInDown(
                from: 100.h,
                delay: const Duration(milliseconds: 100),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: const Image(
                    image: AssetImage('assets/launchLogo.png'),
                  ),
                ),
              ),
              SlideInRight(
                delay: const Duration(milliseconds: 200),
                child: Carousel(),
              ),
              const SizedBox(
                height: 20,
              ),
              SlideInUp(
                from: 100.h,
                delay: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(player).play();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Login(),
                      ),
                    );
                  },
                  child: Text(
                    'Get Started',
                    style: mediumBold(primaryBlack),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryWhite,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 130,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
