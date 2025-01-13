import 'package:flutter/material.dart';

Widget buildTab(String text, int index, int tabIndex) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
      color: tabIndex == index ? Colors.red : Colors.black,
      fontWeight: tabIndex == index ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
