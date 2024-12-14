import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/models/user/user_model.dart';
import 'package:monopoli/screens/onboard/onboard.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:share_plus/share_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../helper/snackbar.dart';
import '../../screens/contact/contact_us.dart';
import '../../screens/onboard/getStarted.dart';
import '../../services/auth.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';

class ProfileSheet extends StatelessWidget {
  final UserModel? user;

  const ProfileSheet({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1C1821),
            Color(0xFFF6B500),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Account',
                    style: mediumBold(primaryWhite),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(
                      FontAwesomeIcons.user,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.username ?? 'Guest',
                        style: mediumBold(primaryWhite),
                      ),
                      const SizedBox(
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ContactUs(),
                    ),
                  );
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
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Contact us',
                        style: mediumText(primaryWhite),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  final urlLink = 'https://www.betcode.live';
                  await Share.share(
                    'Download Gesthim Music for more music.\n$urlLink',
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        Icons.folder_shared_outlined,
                        color: primaryWhite,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        ' Share the app',
                        style: mediumText(primaryWhite),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFFF6B500),
                      title: Text(
                        'Are You sure you want to log out?',
                        style: mediumText(primaryBlack),
                      ),
                      content: Row(
                        children: [
                          TextButton(
                            onPressed: () async {
                              await AuthService.logOut();
                              Navigator.of(ctx).pop();
                              pushScreenWithoutNavBar(
                                context,
                                OnboardingCarousel(),
                              );
                            },
                            child: Text(
                              'Yes',
                              style: mediumText(primaryBlack),
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
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Log out',
                        style: mediumText(primaryWhite),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFFF6B500),
                      title: Text(
                        'Are You sure you want to delete your account?',
                        style: mediumText(primaryBlack),
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
                              style: mediumText(primaryBlack),
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
                      const Icon(
                        Icons.delete_outline_rounded,
                        color: primaryWhite,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Delete your account',
                        style: mediumText(primaryWhite),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
