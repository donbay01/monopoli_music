import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monopoli/screens/auth/login.dart';
import 'package:monopoli/screens/auth/verify_email.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../helper/snackbar.dart';
import '../../services/auth.dart';
import '../../theme/text_style.dart';
import '../../widgets/button/formbutton.dart';
import '../../widgets/form/textfield.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../dashboard/index.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? type;

  bool termsAndCondition = false;
  var key = GlobalKey<FormState>();

  changeTerms(bool newValue) => setState(() => termsAndCondition = newValue);

  @override
  void initState() {
    super.initState();
    emailController.addListener(onListen);
    userNameController.addListener(onListen);
    phoneController.addListener(onListen);
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);
    userNameController.removeListener(onListen);
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void onListen() => setState(() {});

  register() async {
    var valid = key.currentState!.validate();
    if (!valid) {
      return SnackbarHelper.displayToastMessage(
        context: context,
        message: 'You need to fill all required fields',
      );
    }

    if (!termsAndCondition) {
      return SnackbarHelper.displayToastMessage(
        context: context,
        message: 'You need to accept the terms and conditions',
      );
    }

    context.loaderOverlay.show();

    try {
      var cred = await AuthService.register(
        emailController.text,
        passwordController.text,
        userNameController.text,
      );

      await AuthService.createAccount(
        user: cred.user!,
        phone: phoneController.text,
        username: userNameController.text,
        type: type,
      );

      context.loaderOverlay.hide();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyEmail(),
        ),
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image(
                        image: AssetImage('assets/appLogo.png'),
                      ),
                    ),
                    CustomTextField(
                      controller: userNameController,
                      label: 'Username',
                      hint: 'Enter your username',
                      radius: 10,
                      labelStyle: const TextStyle(color: primaryWhite),
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: userNameController.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                userNameController.clear();
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      radius: 10,
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
                      radius: 10,
                      controller: phoneController,
                      label: 'Phone Number',
                      hint: 'Enter your Phone number',
                      prefixIcon: Icon(Icons.phone),
                      suffixIcon: phoneController.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                phoneController.clear();
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
                      radius: 10,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
                      value: type,
                      style: smallText(Colors.white),
                      hint: Text(
                        'Select User type',
                        style: smallText(primaryWhite),
                      ),
                      items: ['Streamer', 'Artist']
                          .map(
                            (a) => DropdownMenuItem(
                              value: a,
                              child: Text(
                                a,
                                style: smallText(Colors.black),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() {
                        type = v;
                      }),
                    ),
                    CheckboxListTile(
                      activeColor: purple,
                      checkColor: primaryBlack,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Wrap(
                        spacing: 3,
                        children: [
                          Text(
                            "By continuing you agree to Desthim's",
                            style: smallText(primaryWhite),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Privacy Policy',
                              style: smallText(primaryWhite),
                            ),
                          ),
                          Text(
                            'and',
                            style: smallText(primaryWhite),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Terms and Conditions',
                              style: smallText(purple),
                            ),
                          ),
                        ],
                      ),
                      value: termsAndCondition,
                      onChanged: (newValue) {
                        setState(() {
                          termsAndCondition = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      color: primaryWhite,
                      function: register,
                      child: Text(
                        'Register',
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
                          "Already have an account?",
                          style: smallText(primaryWhite),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Login(),
                            ),
                          ),
                          child: Text(
                            'Login',
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
