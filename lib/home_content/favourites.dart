import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodrank_update/utils/custom_colors.dart';
import 'package:foodrank_update/food_page.dart';

class Favourites extends HookWidget {

  

  Widget favListItem(BuildContext context) {

    /* Route _createRoute(BuildContext context) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Food(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0, 1);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);

          return SlideTransition(
            position: animation.drive(tween),
          child: child, 
          );
        }
      );
    } */

    return Container(
      height: 300,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FoodPage()));
            },
            child: Container(
            width: 260,
            height: 240,
            child: Column(
              children: [
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Chicken',
                          style: TextStyle(
                            color: CustomColors.lightGrey,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: CustomColors.customGreen,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            height: 6,
                            width: 100,
                            
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Text('Calories per gram: 100',
                      style: TextStyle(
                        color: CustomColors.lightGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400
                      )
                      )
                    ],
                  )
                )
              ]
            ),
            decoration: BoxDecoration(
              color: CustomColors.lightGreenBlack,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 1.5)
                )
              ]
            )
        ),
          ),
          Positioned(
            left: 45,
            top: -50,
              child: Card(
                color: CustomColors.greenBlack,
                elevation: 20,
                child: ClipPath(
                   child: Container(
                    width: 110,
                    height: 100,
                    child: Image.asset('assets/food_item_images/food_item6.jpg',
                    fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.greenBlack,
                    )
                  ),
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 18),
              child: Text(
                'Favourites',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                  color: CustomColors.lightGrey
                )
              ),
            ),
          ],
        ),
        SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                'Foods that you like \n appear here',
                style: TextStyle(
                  color: CustomColors.lightGrey,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 120),
        favListItem(context),
      ]
    );
  }
}