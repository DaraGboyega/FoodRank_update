import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:foodrank_update/food.dart';

class FoodPage extends HookWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Food(query: "100 grams of semolina"),
    );
  }
}