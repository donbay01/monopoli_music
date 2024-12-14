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
import 'package:monopoli/widgets/user/profile_sheet.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/user/user_model.dart';

class UserAvatar extends StatelessWidget {
  final UserModel user;

  const UserAvatar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) => ProfileSheet(
          user: user,
        ),
      ),
      child: const CircleAvatar(
        child: Icon(FontAwesomeIcons.user,size: 20,color: primaryBlack,),
      ),
    );
  }
}
