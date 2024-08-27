import 'package:flutter/material.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:zap_sizer/zap_sizer.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    var tags = ['All', 'Afrobeats', 'Gospel', 'Hip/Hop'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: const UserAvatar(),
            ),
            SizedBox(
              width: 70.w,
              height: 10.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      tags[index],
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
      ],
    );
  }
}
