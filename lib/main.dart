import 'package:flutter/material.dart';
import 'package:foodrank_update/food.dart';
import 'package:foodrank_update/home.dart';
import 'package:foodrank_update/splash_animation/splash_animation.dart';
import 'package:foodrank_update/utils/custom_colors.dart';
import 'package:foodrank_update/walkthrough.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodRank',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ).copyWith(
        accentColor: CustomColors.customGreen,
        canvasColor: CustomColors.greenBlack,
        scaffoldBackgroundColor: CustomColors.greenBlack,
        buttonColor: CustomColors.customGreen,
      ),
      initialRoute: '/',
      routes: {
        '/':  (context) => SplashAnimation(),
        'walkthrough': (context) => Walkthrough(),
        'home': (context) => Home(),
      },
    );
  }
}