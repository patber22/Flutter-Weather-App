import 'package:flutter/material.dart';

Widget currentTile(IconData icon, String topText, String bottomText) {
  return Expanded(
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            ),
          SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topText,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                bottomText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      )
    )
  );
}