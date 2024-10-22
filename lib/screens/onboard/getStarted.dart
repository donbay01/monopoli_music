import 'package:animate_do/animate_do.dart';
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
              'assets/onboarding.png',
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
                height: 15.h,
                width: 40.w,
                child:  Image(
                  image: AssetImage('assets/volume.png'),
                ),
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: const Image(
                  image: AssetImage('assets/appLogo.png'),
                ),
              ),
              SizedBox(height: 100,),
              // Pulse(
              //   delay: const Duration(milliseconds: 500),
              //   child: Text(
              //     'Over 1000+\nMusic online',
              //     style: boldText(primaryWhite),
              //   ),
              // ),
               SizedBox(
                height: 20,
              ),
              SlideInRight(
                from: 90.h,
                delay: const Duration(milliseconds: 100),
                child: GestureDetector(
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
              ),
              const SizedBox(
                height: 20,
              ),
              SlideInLeft(
                from: 90.h,
                delay: const Duration(milliseconds: 100),
                child: PrimaryButton(
                  function: () async {
                    OAuthService.googleAuth(
                      context: context,
                      completer: () {},
                    );
                  },
                  text: 'Continue with Google',
                  icon: const Icon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              // SlideInRight(
              //   from: 90.h,
              //   delay: const Duration(milliseconds: 1200),
              //   child: PrimaryButton(
              //     function: () {
              //       // OAuthService.xAuth(
              //       //   context: context,
              //       // );
              //     },
              //     text: 'Continue with Twitter',
              //     icon: Icon(
              //       FontAwesomeIcons.xTwitter,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // SlideInLeft(
              //   from: 90.h,
              //   delay: const Duration(milliseconds: 1500),
              //   child: PrimaryButton(
              //     function: () {
              //       OAuthService.facebookAuth(context: context);
              //     },
              //     text: 'Continue with Facebook',
              //     icon: Icon(
              //       FontAwesomeIcons.facebook,
              //       color: Colors.blue,
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 40,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: mediumText(primaryWhite),
                  ),
                  SizedBox(width: 10,),
                  TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Login(),
                      ),
                    );
                  }, child: Text('Log in'))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // SlideInUp(
              //   from: 90.h,
              //   delay: const Duration(milliseconds: 1000),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => const Login(),
              //         ),
              //       );
              //     },
              //     child: Container(
              //       height: MediaQuery.of(context).size.height * 0.06,
              //       width: MediaQuery.of(context).size.width,
              //       decoration: BoxDecoration(
              //         border: const GradientBoxBorder(
              //           gradient: LinearGradient(colors: [purple, primaryWhite]),
              //           width: 2,
              //         ),
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           const Icon(
              //             FontAwesomeIcons.signIn,
              //             color: primaryWhite,
              //           ),
              //           const SizedBox(
              //             width: 20,
              //           ),
              //           Text(
              //             'Log in',
              //             style: mediumText(primaryWhite),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
