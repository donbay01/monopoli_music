import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/auth/login.dart';
import 'package:monopoli/onboard/carousal.dart';

import '../genre/index.dart';
import '../theme/colors.dart';
import '../theme/text_style.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  // UserService? service;

  @override
  void initState() {
    super.initState();
    // service = UserService(context);
    // isVerified = service!.firebaseUser()!.emailVerified;
  }

  // @override
  // void didChangeDependencies() {
  //   if (!isVerified) {
  //     sendVerificationEmail();
  //
  //     timer = Timer.periodic(
  //       const Duration(seconds: 3),
  //           (_) => checkEmailVerified(),
  //     );
  //   }
  //
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Future checkEmailVerified() async {
  //   await service!.reloadUser();
  //   if (service!.firebaseUser()!.emailVerified) {
  //     isVerified = service!.firebaseUser()!.emailVerified;
  //     timer?.cancel();
  //     setState(() {});
  //   }
  // }

  // Future sendVerificationEmail() async {
  //   final user = service!.firebaseUser()!;
  //   await user.sendEmailVerification();
  //   setState(() {
  //     canResendEmail = false;
  //   });
  //
  //   await Future.delayed(
  //     const Duration(seconds: 5),
  //   );
  //   setState(() {
  //     canResendEmail = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return isVerified
        ? Login()
        : Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/emailverify.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: Text(
                        'Verify your Email',
                        style: largeText(primaryWhite),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width,
                        child: Image(image: AssetImage('assets/verify.png'))),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'A verification email has been sent to your email, Kindly check your mail and verify your account to continue.',
                        style: small(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Didn't receive an email?",
                        style: mediumText(primaryWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Check your spam or junk. It goes there sometimes!',
                        style: smallText(primaryWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // canResendEmail ? sendVerificationEmail() : null;
                      },
                      icon: const Icon(
                        Icons.email,
                        color: primaryWhite,
                      ),
                      label: Text(
                        'Resend Email',
                        style: smallText(primaryWhite),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        // service!.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingCarousel(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Cancel',
                        style: mediumSemiBold(purple),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        // service!.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenreSelectionPage (),
                          ),
                              (route) => false,
                        );
                      },
                      child: Text(
                        'Test continue',
                        style: mediumSemiBold(primaryWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
