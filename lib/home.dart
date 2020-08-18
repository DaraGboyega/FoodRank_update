import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodrank_update/home_content/calculator.dart';
import 'package:foodrank_update/home_content/favourites.dart';
import 'package:foodrank_update/home_content/search.dart';
import 'package:foodrank_update/utils/custom_colors.dart';

class Home extends HookWidget {

  @override

  Widget build(BuildContext context) {

    final _currentIndex = useState(0);
    final List<Widget> _pages = [Favourites(), SearchPage(), Calculator()];

    NavigationRailDestination textDestination(String text) {
      return NavigationRailDestination(
        icon: SizedBox.shrink(),
        label: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: RotatedBox(
          quarterTurns: -1,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text,
            style: TextStyle(
              fontFamily: 'Montserrat'
            ),
            ),
          )
        ),
          )
      );
    }

    return Scaffold(
      backgroundColor: CustomColors.greenBlack,
      body: Row(
       // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                    backgroundColor: CustomColors.greenBlack,
                    minWidth: 53.0,
                    selectedIndex: _currentIndex.value,
                    onDestinationSelected: (int index){
                      _currentIndex.value = index; 
                    },
                    labelType: NavigationRailLabelType.all,
                    leading: Column(
                      children: [
                        SizedBox(height: 50),
                        InkWell(
                          onTap: (){

                          },
                          child: ImageIcon(
                            AssetImage(
                              "assets/icons/menu2.png"
                            ),
                            color: CustomColors.customGreen,
                          ),
                        ),
                        SizedBox(height: 60)
                      ],
                    ),
                    selectedLabelTextStyle: TextStyle(
                      color: CustomColors.customGreen,
                      fontSize: 14,
                      letterSpacing: 1,
                      decorationThickness: 2.0
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      color: CustomColors.lightGrey,
                      fontSize: 13,
                      letterSpacing: 0.8
                    ),
                    destinations: [
                      textDestination('Favourites'),
                      textDestination('Search'),
                      textDestination('Calculator')
                    ],
                      ),
                  ),
                ),
              );
            }
          ),
          Container(
            width: 1,
            color: CustomColors.customGreen,
          ),
          Expanded(
              child: IndexedStack(
              index: _currentIndex.value,
              children: _pages
            ),
          )
        ],
      )
    );
  }
}