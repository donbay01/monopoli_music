import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../../theme/text_style.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    var tags = [ 'Playlist','Liked Songs ', 'Downloaded', 'Shared'];
    return  Container(
      color: scaffoldBlack,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Library',style: largeText(primaryWhite),),
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.add,color: primaryWhite,)),
                    SizedBox(width: 10,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: primaryWhite,)),
                    SizedBox(width: 10,),
                    UserAvatar()
                  ],
                )
              ],
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: 95.w,
              height: 10.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Chip(
                    backgroundColor: grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      tags[index],
                      style: mediumBold(primaryWhite),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: 3.w,
                ),
                itemCount: tags.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
