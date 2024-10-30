import 'package:flutter/material.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';

class GenreGridPage extends StatelessWidget {
  final List<Map<String, String>> genres = [
    {'name': 'Rock', 'image': 'assets/afrobeats.png'},
    {'name': 'Pop', 'image': 'assets/hiphop.png'},
    {'name': 'Jazz', 'image': 'assets/jazz.png'},
    {'name': 'Hip-Hop', 'image': 'assets/soul.png'},
    {'name': 'Classical', 'image': 'assets/randb.png'},
    {'name': 'Electronic', 'image': 'assets/country.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1, // Adjust for image and text layout
      ),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  genres[index]['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // SizedBox(height: 8),
              Container(
                child: Center(
                  child: Text(
                    genres[index]['name']!,
                    style: mediumSemiBold(primaryWhite)
                  ),
                ),
              )

            ],
          ),
        );
      },
    );
  }
}
