import 'package:flutter/material.dart';
import 'package:monopoli/screens/onboard/getStarted.dart';
import 'package:monopoli/theme/text_style.dart';
import '../../../theme/colors.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/onboarding.png'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image(
                  image: AssetImage('assets/appLogo.png'),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Text(
                'Music for the Soul.',
                style: boldText(primaryWhite),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enjoy the best songs from your\nfavourite artists, Tailor your playlist\n to your taste.',
                style: mediumSemiBold(primaryWhite),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => GetStarted()));
                },
                child: Text(
                  'Get Started',
                  style: mediumBold(primaryWhite),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 130),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: primaryWhite, width: 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
