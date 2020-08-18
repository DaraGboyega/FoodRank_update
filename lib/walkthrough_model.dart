import 'package:foodrank_update/utils/custom_colors.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroItems {
  static final List<PageViewModel> introItems = [
    PageViewModel(
      title: Text(''),                            
      pageColor: CustomColors.greenBlack,
      mainImage: SvgPicture.asset('assets/walkthrough_images/undraw_Hamburger_8ge6.svg',
      alignment: Alignment.center,
      height: 250,
      width: 250,
      ),
      body: Text('Take the next step to a healthy lifestyle by using FoodRank to analyze your diet'),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        fontFamily: 'Roboto',
        color: CustomColors.lightGrey
      ),
      bubbleBackgroundColor: CustomColors.customGreen
    ),
//'assets/walkthrough_images/undraw_diet_ghvw.svg'
    PageViewModel(
      title: Text(''),
      pageColor: CustomColors.greenBlack,
      mainImage: SvgPicture.asset('assets/walkthrough_images/undraw_diet_ghvw.svg',
      alignment: Alignment.center,
      height: 250,
      width: 250,
      ),
      body: Text('FoodRank breaks down the dietary content and nutritional value of each meal'),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        fontFamily: 'Roboto',
        color: CustomColors.lightGrey
      ),
      bubbleBackgroundColor: CustomColors.customGreen
    ),

    PageViewModel(
      title: Text(''),
      pageColor: CustomColors.greenBlack,
      mainImage: SvgPicture.asset('assets/walkthrough_images/undraw_healthy_options_sdo3.svg',
      alignment: Alignment.center,
      height: 250,
      width: 250,
      ),
      body: Text("To use enter quantity of food explicitly using this syntax: 'one kilo of chicken'"),
      bodyTextStyle: TextStyle(
        fontSize: 18,
        fontFamily: 'Roboto',
        color: CustomColors.lightGrey
      ),
      bubbleBackgroundColor: CustomColors.customGreen
    )
  ];
}