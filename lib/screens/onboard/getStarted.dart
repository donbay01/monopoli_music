import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:monopoli/screens/auth/login.dart';
import 'package:monopoli/screens/auth/register.dart';
import 'package:monopoli/services/oAuth.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/button/primary_button.dart';
import 'package:zap_sizer/zap_sizer.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key, this.closeModal});

  final Function? closeModal;

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/getstarted.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 1.h,
                width: 5.w,
                child: const Image(
                  image: AssetImage('assets/appLogo.png'),
                ),
              ),
              SizedBox(
                height: 15.h,
                width: 40.w,
                child: const Image(
                  image: AssetImage('assets/volume.png'),
                ),
              ),
              Text(
                'Over 1000+\nMusic online',
                style: boldText(primaryWhite),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Register(),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: 100.w,
                  decoration: BoxDecoration(
                    border: const GradientBoxBorder(
                      gradient: LinearGradient(colors: [purple, primaryWhite]),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.app_registration,
                        color: primaryWhite,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Sign Up',
                        style: mediumText(primaryWhite),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                function: () async {
                  OAuthService.googleAuth(
                    completer: () {},
                  );
                },
                text: 'Continue with Google',
                icon: const Icon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                function: () {
                  OAuthService.xAuth();
                },
                text: 'Continue with Twitter',
                icon: Icon(
                  FontAwesomeIcons.xTwitter,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                function: () {
                  OAuthService.facebookAuth();
                },
                text: 'Continue with Facebook',
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Already have an account?',
                style: mediumText(primaryWhite),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Login(),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: const GradientBoxBorder(
                      gradient: LinearGradient(colors: [purple, primaryWhite]),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.signIn,
                        color: primaryWhite,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Log in',
                        style: mediumText(primaryWhite),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
