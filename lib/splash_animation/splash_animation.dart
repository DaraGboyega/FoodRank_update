import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodrank_update/utils/custom_colors.dart';
import 'package:foodrank_update/walkthrough.dart';

class SplashAnimation extends HookWidget {
  @override
  Widget build(BuildContext context) {

    Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Walkthrough(),
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
    } 

    final controller = useAnimationController(
      duration: Duration(seconds: 8)
    );

    Future _startAnimation() async {
      try {
        await controller.forward().orCancel;
      } on TickerCanceled {
        print('Animation Failed');
      }
    }

    useEffect(
      () {
        _startAnimation();
        controller.addStatusListener((status) {
          if (status == AnimationStatus.completed){
            Navigator.of(context).pushReplacementNamed('walkthrough');
          }
        });
        return null;
      }, const []
    );
    return AnimatedIntro(controller: controller);
  }
}

class AnimatedIntro extends HookWidget{
  AnimatedIntro({Key key, this.controller}) : 

  color = ColorTween(
    begin: Colors.transparent,
    end: CustomColors.customGreen
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Interval(0.0, 0.2,
    curve: Curves.easeIn
    )
  )),
  spinnerColor = ColorTween(
    begin: Colors.transparent,
    end: CustomColors.customGreen
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Interval(0.5, 0.6,
    curve: Curves.easeIn
    )
  )),
  opacity = Tween(
    begin: 1.0,
    end: 0.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval( 0.3, 0.5,
      curve: Curves.easeIn
      )
    )
  ),
  spinnerOffset = Tween(
    begin: 0.0,
    end: 50.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(0.6, 0.7,
      curve: Curves.bounceOut
      )
    )
  ),
  rotateAngle = Tween(
    begin: 0.0,
    end: 1.0
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(0.7, 1.0,
      curve: Curves.decelerate)
    )
  ),
  super(key: key);

  final Animation<double> controller;
  final Animation<Color> color;
  final Animation<Color>  spinnerColor;
  final Animation<double> opacity;
  final Animation<double> spinnerOffset;
  final Animation<double> rotateAngle;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColors.greenBlack,
        body: AnimatedBuilder(
          animation: controller, 
          builder: (BuildContext context, Widget child){
            return Container(
              child: Stack(
                children: [
                  Container(
                    color: CustomColors.greenBlack,
                  ),
                  Opacity(
                    opacity: opacity.value,
                      child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Container(
                              child: Center(
                                child: Text(
                                  'Food',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 40,
                                    color: CustomColors.lightGrey
                                  )
                                ),
                              ),
                            ),
                            SizedBox(width: 7),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color.value,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                width: 135,
                                height: 65,
                                child: Center(
                                  child: Text(
                                    'Rank',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 40,
                                      color: CustomColors.lightGrey
                                    )
                                  ),
                                ),
                              ),
                            )
                          ],)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            RotationTransition(
                              turns: rotateAngle, 
                              child: Align(
                                alignment: Alignment.topCenter,
                                 child: Transform.translate(
                                offset: Offset(-spinnerOffset.value, 0.0),
                                  child: Container(
                                  width: 20,
                                  height: 20,  
                                  decoration: BoxDecoration(
                                    color: spinnerColor.value,
                                    shape: BoxShape.circle
                                  )
                                ),
                                  ),
                              ),
                            ),
                            RotationTransition(
                              turns: rotateAngle,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                child: Transform.translate(
                                offset:  Offset(spinnerOffset.value, 0.0),
                                  child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: spinnerColor.value,
                                    shape: BoxShape.circle
                                  ),
                                ),
                                  ),
                              ),
                            ),
                            RotationTransition(
                              turns: rotateAngle,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                child: Transform.translate(
                                offset: Offset(0.0, spinnerOffset.value * 1.3),
                                  child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: spinnerColor.value,
                                    shape: BoxShape.circle
                                  ),
                                ),
                                  ),
                              ),
                            )
                          ]
                        ),
                      ],
                    ),
                  )
                ]
              )
            );
          }
      )
    );
  }
}