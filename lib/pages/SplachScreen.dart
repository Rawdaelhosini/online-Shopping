
import 'package:api/onboardring/welcome.dart';
import 'package:easy_splash/easy_splash.dart';

import 'package:flutter/material.dart';

class Splachscreen extends StatefulWidget {
  const Splachscreen({super.key});

  @override
  State<Splachscreen> createState() => _SplachscreenState();
}

class _SplachscreenState extends State<Splachscreen> {
  @override
  Widget build(BuildContext context) {
    return const EasySplash(
      
          seconds: 5,
          nextScreen: WelcomePage(),
          indicatorHeight: 1,
          imgType: ImgType.assetImage,
          image: "assets/logo.png",
          hasIndicator: false
          
    );
  }
}