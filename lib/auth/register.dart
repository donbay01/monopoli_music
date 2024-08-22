import 'package:flutter/material.dart';
import 'package:monopoli/auth/login.dart';
import 'package:monopoli/auth/verify_email.dart';
import 'package:monopoli/theme/colors.dart';
import '../theme/text_style.dart';
import '../widgets/button/formbutton.dart';
import '../widgets/form/textfield.dart';

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

  // register() async {
  //   var valid = key.currentState!.validate();
  //   if (!valid) {
  //     return SnackbarHelper.displayToastMessage(
  //       context: context,
  //       message: 'You need to fill all required fields',
  //     );
  //   }
  //
  //   if (!termsAndCondition) {
  //     return SnackbarHelper.displayToastMessage(
  //       context: context,
  //       message: 'You need to accept the terms and conditions',
  //     );
  //   }
  //
  //   context.loaderOverlay.show();
  //
  //   // try {
  //   //   var cred = await AuthService.signUp(
  //   //     email: emailController.text,
  //   //     password: passwordController.text,
  //   //   );
  //   //   await AuthService.createAccount(
  //   //     credential: cred,
  //   //     displayName: userNameController.text,
  //   //   );
  //   //
  //   //   context.loaderOverlay.hide();
  //   //
  //   //   Navigator.of(context).push(
  //   //     MaterialPageRoute(
  //   //       builder: (_) => const Homepage(),
  //   //     ),
  //   //   );
  //   // } on FirebaseAuthException catch (e) {
  //   //   context.loaderOverlay.hide();
  //   //   SnackbarHelper.displayToastMessage(
  //   //     context: context,
  //   //     message: e.message!,
  //   //   );
  //   // }
  // }

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
                        child: Image(image: AssetImage('assets/registerEmail.png'))),
                    SizedBox(height: 70,),
                    CustomTextField(
                      controller: userNameController,
                      label: 'Username',
                      hint: 'Enter your username',
                      radius: 25,
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
                      radius: 25,
                      isEmail: true,
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
                      radius: 25,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CheckboxListTile(
                      activeColor: purple,
                      checkColor: primaryWhite,
                      title: Text(
                        'I accept the Terms and Conditions',
                        style: smallText(primaryWhite),
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
                      height: 5,
                    ),
                    CustomButton(
                      function: () => Navigator.push(context, MaterialPageRoute(builder: (_)=> VerifyEmail())),
                      child: Text(
                        'Register',
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
                          "Already have an account ?",
                          style: smallText(primaryWhite),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context, MaterialPageRoute(builder: (_) => Login())),
                          child: Text(
                            'Login',
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
