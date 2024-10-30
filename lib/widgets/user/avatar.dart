import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:monopoli/helper/snackbar.dart';
import 'package:monopoli/screens/contact/contact_us.dart';
import 'package:monopoli/screens/onboard/getStarted.dart';
import 'package:monopoli/screens/onboard/onboard.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/user/user_model.dart';

class UserAvatar extends StatelessWidget {
  final UserModel? user;

  const UserAvatar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showProfileDetails(context);
      },
      child: CircleAvatar(
        child: Image(image: AssetImage('assets/avatar.png')),
      ),
    );
  }

  void _showProfileDetails(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          height: height * 0.7,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1C1821), Color(0xFF2F1F43)]),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: primaryWhite,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Account',
                        style: mediumBold(primaryWhite),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Image(image: AssetImage('assets/avatar.png')),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.username ?? 'Guest',
                            style: mediumBold(primaryWhite),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            user?.email ?? 'desthimMusic@gmail.com',
                            style: smallText(grey),
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: grey,
                    height: 50,
                  ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.edit,
                  //         color: primaryWhite,
                  //         size: 25,
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Text(
                  //         'Edit your profile',
                  //         style: mediumBold(primaryWhite),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ContactUs()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail_outline_outlined,
                            color: primaryWhite,
                            size: 25,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Contact us',
                            style: mediumBold(primaryWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async{
                      final urlLink =  'https://www.betcode.live';
                      await Share.share(
                        'Download Gesthim Music for more music.\n$urlLink',
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.share,
                            color: primaryWhite,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            ' Share the app',
                            style: mediumBold(primaryWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: Color(0xFF2F1F43),
                          title: Text(
                            'Are You sure you want to log out?',
                            style: mediumText(primaryWhite),
                          ),
                          content: Row(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  await AuthService.logOut();
                                  Navigator.of(ctx).pop();
                                  pushScreenWithoutNavBar(
                                    context,
                                    GetStarted(),
                                  );
                                },
                                child: Text(
                                  'Yes',
                                  style: mediumText(primaryWhite),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text(
                                  'No',
                                  style: mediumText(Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: primaryWhite,
                            size: 25,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Log out',
                            style: mediumBold(primaryWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: Color(0xFF2F1F43),
                          title: Text(
                            'Are You sure you want to delete your account?',
                            style: mediumText(primaryWhite),
                          ),
                          content: Row(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  try {
                                    context.loaderOverlay.show();
                                    await AuthService.deleteAccount();
                                    context.loaderOverlay.hide();
                                    Navigator.of(ctx).pop();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GetStarted(),
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
                                  'Yes',
                                  style: mediumText(primaryWhite),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text(
                                  'No',
                                  style: mediumText(Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 25,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Delete your account',
                            style: mediumBold(primaryWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
