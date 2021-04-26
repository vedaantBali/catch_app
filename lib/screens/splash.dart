import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset('assets/launch_image.png', height: 198, width: 198,),
        ),
      ),
    );
  }
}
