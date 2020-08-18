import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:foodrank_update/models/json_model.dart';
import 'dart:convert';
import 'package:foodrank_update/keys/keys.dart';

class AnalysisProvider extends ChangeNotifier {

  @override
  void notifyListeners();

  Future<Analysis> fetchAnalysis(String query) async {
    final editQuery = query.replaceAll(" ", "%20");
    final response =  await http.get('https://api.edamam.com/api/nutrition-data?app_id=${Keys.app_ID}&app_key=${Keys.app_Key}&ingr=$editQuery');
    final jsonResponse = jsonDecode(response.body);
    return Analysis.fromMap(jsonResponse);
  }  
}