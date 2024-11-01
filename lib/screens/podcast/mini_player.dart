import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(Icons.play_circle_fill, color: Colors.deepPurple, size: 36),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Playing: Episode Title', style: TextStyle(fontSize: 16)),
                LinearProgressIndicator(value: 0.3),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.skip_next, color: Colors.deepPurple),
            onPressed: () {
              // Handle skip next
            },
          ),
        ],
      ),
    );
  }
}
