import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:monopoli/screens/onboard/onboard.dart';
import 'package:monopoli/screens/onboard/getStarted.dart';
import 'package:monopoli/services/auth.dart';
import '../../helper/snackbar.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';
import '../../widgets/button/formbutton.dart';
import '../../widgets/form/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  reset() async {
    context.loaderOverlay.show();

    try {
      await AuthService.resetPassword(emailController.text);
      context.loaderOverlay.hide();

      SnackbarHelper.displayToastMessage(
        context: context,
        message: 'Email has been sent',
      );
    } on FirebaseAuthException catch (e) {
      context.loaderOverlay.hide();
      SnackbarHelper.displayToastMessage(
        context: context,
        message: e.message!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text(
                    'Reset Your Password',
                    style: largeText(primaryWhite),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  controller: emailController,
                  label: 'Email Address',
                  hint: 'Enter your email address',
                  isEmail: true,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  color: primaryWhite,
                  function: () => reset(),
                  child: Text(
                    'Reset Password',
                    style: mediumBold(primaryBlack),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => GetStarted())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.house,
                        color: purple,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Return Home',
                        style: mediumText(primaryWhite),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
