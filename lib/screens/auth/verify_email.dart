import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monopoli/helper/snackbar.dart';
import '../../services/auth.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';
import '../genre/index.dart';
import '../onboard/onboard.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isVerified = false;
  Timer? timer;
  bool canResendEmail = false;
  AuthService? service;

  @override
  void initState() {
    service = AuthService();
    isVerified = service!.firebaseUser()!.emailVerified;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    var user = AuthService.getUser()!;
    await user.reload();
    if (service!.firebaseUser()!.emailVerified) {
      isVerified = service!.firebaseUser()!.emailVerified;
      timer?.cancel();
      setState(() {});

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const GenreSelectionPage(),
        ),
            (route) => false,
      );

    }

  }

  Future sendVerificationEmail() async {
    final user = service!.firebaseUser()!;
    await user.sendEmailVerification();
    setState(() {
      canResendEmail = false;
    });

    await Future.delayed(
      const Duration(seconds: 5),
    );
    setState(() {
      canResendEmail = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onboarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Text(
                  'Verify your Email',
                  style: mediumSemiBold(primaryWhite),
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
                height: 50,
              ),
              Center(
                child: Text(
                  'A verification link has been sent to your email, Kindly check your mail and verify your account to continue.',
                  style: smallText(primaryWhite),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Didn't receive an email?",
                style: mediumText(purple),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5,),
              Text(
                'Check your spam or junk. It goes there sometimes!',
                style: smallText(Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  canResendEmail ? sendVerificationEmail() : null;
                  SnackbarHelper.displayToastMessage(
                    context: context,
                    message: 'Email Sent',
                  );
                },
                icon: const Icon(
                  Icons.email,
                  color: primaryBlack,
                ),
                label: Text(
                  'Resend Email',
                  style: mediumBold(primaryBlack),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryWhite,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  AuthService.logOut();
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
                  style: mediumBold(purple),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );

  }
}
