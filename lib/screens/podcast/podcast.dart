import 'package:flutter/material.dart';
import 'package:monopoli/screens/podcast/mini_player.dart';
import 'package:monopoli/screens/podcast/podcast_description.dart';
import 'package:monopoli/screens/podcast/podcast_header.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../theme/text_style.dart';
import 'episode_list.dart';

class PodcastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientText(
                  'Podcast',
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                  colors: [purple, primaryWhite],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Home',style: mediumSemiBold(primaryWhite),),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Podcast Library',style: mediumBold(primaryWhite),),
                Icon(Icons.arrow_forward_ios,size: 16,color: purple,)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: height * 0.3,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                      color: Color(0xFF524127),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Container(
                                height: height * 0.14,
                                width: width * 0.35,
                                child: Image(image: AssetImage('assets/soul.png'),fit: BoxFit.contain,)),
                          ),
                          SizedBox(height: 5,),
                          Text('Recap of the First Four',style: smallBold(primaryWhite),),
                          SizedBox(height: 5,),
                          Text('In this episode, we revisited the first four topics to refresh your memory on what we...',style: tiny(primaryWhite),),
                          SizedBox(height: 10,),
                          Container(
                            height: height * 0.03,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                              color: primaryWhite,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow,color: primaryBlack,size: 18,),
                                SizedBox(width: 2,),
                                Text('46m',style: tiny(primaryBlack),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: height * 0.3,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                        color: Color(0xFF5F172B),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Container(
                                height: height * 0.14,
                                width: width * 0.35,
                                child: Image(image: AssetImage('assets/randb.png'),fit: BoxFit.contain,)),
                          ),
                          SizedBox(height: 5,),
                          Text('Recap of the First Four',style: smallBold(primaryWhite),),
                          SizedBox(height: 5,),
                          Text('In this episode, we revisited the first four topics to refresh your memory on what we...',style: tiny(primaryWhite),),
                          SizedBox(height: 10,),
                          Container(
                            height: height * 0.03,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: primaryWhite,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow,color: primaryBlack,size: 18,),
                                SizedBox(width: 2,),
                                Text('46m',style: tiny(primaryBlack),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Shows',style: mediumBold(primaryWhite),),
                Icon(Icons.arrow_forward_ios,size: 16,color: purple,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
