import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/screens/auth/register.dart';
import 'package:monopoli/helper/snackbar.dart';
import 'package:monopoli/monopoli.dart';
import 'package:monopoli/screens/dashboard/index.dart';
import 'package:monopoli/services/auth.dart';
import 'package:zap_sizer/zap_sizer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';
import '../../widgets/button/formbutton.dart';
import '../../widgets/form/textfield.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.addListener(onListen);
    passwordController.addListener(onListen);
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image(
                        image: AssetImage('assets/appLogo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                        image: AssetImage('assets/login.png'),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      radius: 25,
                      isEmail: true,
                      controller: emailController,
                      label: 'Email Address',
                      hint: 'Enter your email address',
                      prefixIcon: Icon(Icons.email_outlined),
                      suffixIcon: emailController.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                emailController.clear();
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password*',
                      hint: 'xxxxxxxxxx',
                      isPassword: true,
                      radius: 25,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: smallText(primaryWhite),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      color: primaryWhite,
                      function: () async {
                        context.loaderOverlay.show();
                        try {
                          await AuthService.login(
                            emailController.text,
                            passwordController.text,
                          );
                          context.loaderOverlay.hide();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Dashboard(),
                            ),
                            (route) => false,
                          );
                        } on FirebaseAuthException catch (e) {
                          context.loaderOverlay.hide();
                          SnackbarHelper.displayToastMessage(
                            context: context,
                            message: e.message!,
                          );
                        }
                      },
                      child: Text(
                        'Sign in',
                        style: mediumBold(primaryBlack),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ?",
                          style: smallText(primaryWhite),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Register(),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: mediumText(purple),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
