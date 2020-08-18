import 'package:foodrank_update/loader.dart';
import 'package:foodrank_update/models/provider_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodrank_update/utils/custom_colors.dart';
import 'package:foodrank_update/models/json_model.dart';


class Food extends HookWidget {

  final String query;
  /* Analysis result;
  List<String> dietLabels;
  List<String> healthLabels;
  Map<String, TotalDaily> daily;
  Map<String, TotalDaily> totalNutrient; */

  Food({Key key , @required this.query}) :  super(key: key);

  

  /* final List<String> dietLabels = [
        "HIGH_PROTEIN",
        "LOW_FAT",
        "LOW_CARB",
        "LOW_SODIUM"
    ];

  final List<String> healthLabels = [
        "LOW_FAT_ABS",
        "SUGAR_CONSCIOUS",
        "LOW_SUGAR",
        "KIDNEY_FRIENDLY",
        "PALEO",
        "SPECIFIC_CARBS",
        "DAIRY_FREE",
        "GLUTEN_FREE",
        "WHEAT_FREE",
        "EGG_FREE",
        "MILK_FREE",
        "PEANUT_FREE",
        "TREE_NUT_FREE",
        "SOY_FREE",
        "FISH_FREE",
        "SHELLFISH_FREE",
        "PORK_FREE",
        "CRUSTACEAN_FREE",
        "CELERY_FREE",
        "MUSTARD_FREE",
        "SESAME_FREE",
        "LUPINE_FREE",
        "MOLLUSK_FREE",
        "ALCOHOL_FREE",
        "NO_OIL_ADDED",
        "NO_SUGAR_ADDED",
        "KOSHER"
    ];

  


  final Map<String, TotalDaily> daily = {
    "ENERC_KCAL" : TotalDaily(
      label: "Energy",
      quantity: 7.6,
      unit: Unit.EMPTY
    ),
    "FAT" : TotalDaily(
      label: "Fat",
      quantity: 2.95,
      unit: Unit.EMPTY
    ),
    "FASAT" : TotalDaily(
      label: "Saturated",
      quantity: 5.15,
      unit: Unit.EMPTY
    ),
    "CHOCDF" : TotalDaily(
      label: "Carbs",
      quantity: 0.412,
      unit: Unit.EMPTY
    ),
    "FIBTG" : TotalDaily(
      label: "Fiber",
      quantity: 0.412,
      unit: Unit.EMPTY
    )
  };

  final Map<String, TotalDaily> totalNutrient = {
    "ENERC_KCAL" : TotalDaily(
      label: "Energy",
      quantity: 152.0,
      unit: Unit.KCAL
    ),
    "FAT" : TotalDaily(
      label: "Fat",
      quantity: 1.92,
      unit: Unit.G
    ),
    "FASAT" : TotalDaily(
      label: "Saturated",
      quantity: 1.03,
      unit: Unit.G
    ),
    "FAMS" : TotalDaily(
      label: "Monounsaturated",
      quantity: 0.412,
      unit: Unit.G
    ),
    "FOLDFE" : TotalDaily(
      label: "Folate equivalent (total)",
      quantity: 0.412,
      unit: Unit.UNIT_G
    )
  }; */    

  Widget dietLabelGrid(List<String> dietLabels) {

    List<String> editedLabels = [];
          dietLabels.forEach((element) {                                                                                                                                                                                                                                                                                                                                                                                                        
            editedLabels.add(element.replaceAll('_', ' '));                                                                                                                                                                     
          });

    return SliverGrid(  
      //itemCount: editedLabels.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 1, childAspectRatio: 2),
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
          return Chip(label: Text(
            editedLabels[index],
            style: TextStyle(
              color: CustomColors.lightGreenBlack,
            ),
          ),
          backgroundColor: CustomColors.customGreen,
          );
        },
        childCount: editedLabels.length
      )
    );
  }

  Widget  nutrientsList(Map<String, TotalDaily> nutrientsMap) {

    List<TotalDaily> totalDaily = [];

    nutrientsMap.forEach((key, value) {
      totalDaily.add(value);
    });

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index){
           var parsedUnit = '';
          if(totalDaily[index].unit == Unit.G) {
            parsedUnit = 'g';
          } else if (totalDaily[index].unit == Unit.KCAL) {
            parsedUnit = 'kcal';
          } else if (totalDaily[index].unit == Unit.MG) {
            parsedUnit = 'mg';
          } else if (totalDaily[index].unit == Unit.UNIT_G) {
            parsedUnit = 'µg';
          } else if (totalDaily[index].unit == Unit.EMPTY) {
            parsedUnit = '%';
          }

          final parseQuantity = totalDaily[index].quantity.toDouble().toStringAsFixed(2);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    totalDaily[index].label,
                    style: TextStyle(
                      fontSize: 20,
                      color: CustomColors.lightGrey,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    //totalDaily[index].quantity.toString(),
                    parseQuantity,
                    style: TextStyle(
                      fontSize: 17,
                      color: CustomColors.customGreen,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    parsedUnit,
                    style: TextStyle(
                      fontSize: 17,
                      color: CustomColors.lightGrey,
                      fontFamily: 'Montserrat'
                    ),
                  )
                ],
              )
            ),
          );
        },
        childCount: totalDaily.length
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: CustomColors.greenBlack,
      child: ChangeNotifierProvider(
        create: (context) => AnalysisProvider(),
        child: Consumer<AnalysisProvider>(
          builder: (context, model, child) {
            return FutureBuilder<Analysis>(
              future: model.fetchAnalysis(query),
              builder: (context, snapshot) {

                if (snapshot.hasError) print('Analysis error: ${snapshot.error.toString()}');
                 switch (snapshot.connectionState) {
                   case ConnectionState.none:
                   return Container();

                   case ConnectionState.done:
                   return Container();
                    case ConnectionState.waiting:
                    return Container(
                    child: Center(
                      child: ColorLoader(colors: [CustomColors.customGreen, CustomColors.lightGrey]),
                    ),
                  );

                  default: 
                  if (snapshot.hasError) {

                    return Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline),
                            SizedBox(),
                            Text(
                              'There was error try again'
                            )
                          ],
                        )
                      )
                    );

                  } else {

                    return CustomScrollView(
                      shrinkWrap: true,
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Container(
                                height: 70,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.arrow_back_ios,
                                        color: CustomColors.customGreen,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 90),
                                    /* Padding(
                                      padding: const EdgeInsets.only(bottom: 7.0),
                                      child: Text('Analysis',
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: CustomColors.lightGrey,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500
                                      ),
                                      ),
                                    ) */
                                  ]
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: Text(
                                      'Analysis',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 50,
                                        color: CustomColors.lightGrey
                                      )
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 90),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 28.0),
                                      child: Text(
                                        'Calories',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: CustomColors.lightGrey,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 100),
                                    Text(
                                      snapshot.data.calories.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: CustomColors.customGreen,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600
                                      )
                                    )
                                  ]
                                )
                              ),
                              SizedBox(height: 50),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 28.0),
                                      child: Text(
                                        'Total Weight',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: CustomColors.lightGrey,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 65),
                                    Text(
                                      snapshot.data.totalWeight.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: CustomColors.customGreen,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600
                                      )
                                    )
                                  ]
                                )
                              ),
                              SizedBox(height: 60),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Diet Labels',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: CustomColors.lightGrey,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500
                                      )
                                    )
                                  ]
                                )
                              ),
                            ]
                          ),
                        ),
                        dietLabelGrid(snapshot.data.dietLabels),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(height: 40),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Health Labels',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: CustomColors.lightGrey,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500
                                      )
                                    )
                                  ]
                                )
                              ),
                            ]
                          )
                        ),
                        dietLabelGrid(snapshot.data.healthLabels),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(height: 40),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Nutrients',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: CustomColors.lightGrey,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500
                                      )
                                    )
                                  ]
                                )
                              ),
                              SizedBox(height: 20),
                            ]
                          )
                        ),
                        nutrientsList(snapshot.data.totalNutrients),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SizedBox(height: 50),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Recommended Daily \n           Serving',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: CustomColors.lightGrey,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500
                                      )
                                    )
                                  ]
                                )
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0),
                                      child: Text(
                                        '*Based on a 2000 calorie diet',
                                        style: TextStyle(
                                          color: CustomColors.lightGrey,
                                          fontSize: 18
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              SizedBox(height: 20),
                            ]
                          )
                        ),
                        nutrientsList(snapshot.data.totalDaily)
                      ]
                    );
                    
                  }
                 }
              }
            );
          }
        ),
      )
    );
  }
}