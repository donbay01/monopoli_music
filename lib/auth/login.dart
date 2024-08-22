import 'package:flutter/material.dart';
import 'package:monopoli/auth/register.dart';

import '../theme/colors.dart';
import '../theme/text_style.dart';
import '../widgets/button/formbutton.dart';
import '../widgets/form/textfield.dart';
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
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/email.png')
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image(
                      image: AssetImage('assets/appLogo.png'),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Image(image: AssetImage('assets/login.png'))),
                  SizedBox(height: 70,),
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
                    function: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_)=> Homepage()));
                    },
                    child: Text(
                      'Login',
                      style: mediumBold(primaryWhite),
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
                            context, MaterialPageRoute(builder: (_) => Register())),
                        child: Text(
                          'Register',
                          style: medium(),
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
    );
  }
}
