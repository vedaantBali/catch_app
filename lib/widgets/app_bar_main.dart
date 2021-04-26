import 'package:flutter/material.dart';

Widget appBarMain(BuildContext buildContext) {
  return AppBar(
    title: Text(
        'CatchApp',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 20
        ),
    ),
  );
}