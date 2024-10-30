import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../theme/colors.dart';
import '../../theme/text_style.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  _sendEmail() async {
    launchUrlString("mailto:desthimMusic@gmail.com");
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: scaffoldBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Help & Support',
          style: mediumText(primaryWhite),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: primaryWhite,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 70,
          ),
          Image(
            height: 30.h,
            image: const AssetImage('assets/care.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.envelopesBulk,
                  size: 30,
                  color: purple,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Send us an email for assistance',
                  style: mediumText(primaryWhite),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () {
              _sendEmail();
            },
            child: Text(
              'desthimMusic@gmail.com',
              style: mediumText(searchGrey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              _sendEmail();
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryWhite),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Contact Us',
                style: mediumBold(primaryBlack),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Or',
            style: mediumText(Colors.white),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => launchUrlString('https://t.me/Freekelvinbets'),
                  child: Icon(
                    FontAwesomeIcons.telegram,
                    color: Colors.blueGrey,
                    size: 24.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () =>
                      launchUrlString('https://betcode.live'),
                  child: Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.blue,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
