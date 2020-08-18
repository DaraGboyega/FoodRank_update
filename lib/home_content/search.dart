import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodrank_update/food.dart';
import 'package:foodrank_update/utils/custom_colors.dart';

class SearchPage extends HookWidget{

  Widget build(BuildContext context) {

    var _showAnalysis = false;
    var _textController = useTextEditingController();
    var _controller = useAnimationController(duration: Duration(milliseconds: 700));
    var _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    var _animation = Tween<double>(begin: 320, end: 280).animate(_curve);
    var _isChanged = useState(false)..addListener(() {
      
      if (_controller.isCompleted) {
        _controller.reverse();
      } else _controller.forward();
    });


    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [ 
                SizedBox(
                  height: 60,
                ),
                Stack(
                  children: [
                    Row(
                      children:[
                        Container(
                          width: 350,
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 22.0),
                                child: InkWell(
                                  onTap: () {
                                    _showAnalysis = false;
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    _isChanged.value = !_isChanged.value;
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  child: Icon(Icons.search,
                                  color: CustomColors.customGreen,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ]
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 17.0),
                              child: Container(
                                height: 55,
                                width: _animation.value,
                                decoration: BoxDecoration(
                                  color: CustomColors.lightGreenBlack,
                                  borderRadius: BorderRadius.circular(13)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: TextField(
                                    controller: _textController,
                                    style: TextStyle(
                                      color: CustomColors.lightGrey
                                    ),
                                    decoration: InputDecoration.collapsed(hintText: 'Enter query e.g 100 grams of semolina',
                                    hintStyle: TextStyle(
                                      color: CustomColors.customGreen,
                                      fontSize: 16
                                    ),
                                    ),
                                    showCursor: true,
                                    onTap: () {
                                      _isChanged.value = !_isChanged.value;
                                    },
                                    onEditingComplete: () {
                                      _isChanged.value = !_isChanged.value;
                                    FocusScopeNode currentFocus = FocusScope.of(context);  
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    },
                                      ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    )
                  ]
                ),
                SizedBox(height: 50),
                _showAnalysis == true
                ? Food(query: _textController.text)
                : Container(
                  child: Center(
                    child: Text(
                      'Analyse your food now',
                      
                    ),
                  )
                )
              ]
            )
          ),
        ],
      )
    );
  }
}