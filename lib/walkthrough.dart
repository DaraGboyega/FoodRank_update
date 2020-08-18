import 'package:flutter/material.dart';
import 'package:foodrank_update/utils/custom_colors.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:foodrank_update/walkthrough_model.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IntroViewsFlutter(
          IntroItems.introItems,
          showSkipButton: false,
          onTapDoneButton: (){
            Navigator.of(context).pushReplacementNamed('home');
          },
          pageButtonTextStyles: TextStyle(
            color: CustomColors.lightGrey,
            fontFamily: 'Montserrat',
            fontSize: 18.0
          ),
          background: CustomColors.greenBlack,
        )
      )
    );
  }
}