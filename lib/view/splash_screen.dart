import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_weather_app/view/constant.dart';
import 'package:my_weather_app/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueAccent,
      body:
      Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image(image: AssetImage('assets/images/imgSky.png')),
          Text('Weather App',style: cityNameTextStyle,),
        ],),
      ),);
  }
}
