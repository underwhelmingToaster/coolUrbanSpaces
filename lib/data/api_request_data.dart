import 'dart:convert';
import 'dart:async';

import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:http/http.dart' as http;

class ApiRequestData implements DataProvider{
  static final ApiRequestData _requestData = ApiRequestData._internal();

  factory ApiRequestData(){
    return _requestData;
  }

  ApiRequestData._internal();

    Future<List<Suggestion>> getAllSuggestions() async {
    final response = await http.get(Uri.parse('/data/suggestion/all'));

    if(response.statusCode == 200) {
      List<dynamic> suggestionList = jsonDecode(response.body);
      return suggestionList.map((dict) => Suggestion.fromJson(dict)).toList();

    }else{
      throw Exception('Failed to load all suggestions. Status: ' + response.statusCode.toString());
    }
  }

  Future<Suggestion> getSuggestion(int id) async {
    final response = await http.get(Uri.parse('/data/suggestion/' + id.toString()));
    if(response.statusCode == 200){
      return Suggestion.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load single suggestion. Status: ' + response.statusCode.toString());
    }
  }

  Future<void> postSuggestion(Suggestion suggestion) async {
    final response = await http.post(Uri.parse('/data/suggestion/add'), body: jsonEncode(suggestion.toJson()), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200){
      return;
    }else{
      throw Exception('Failed to post new Suggestion. Status: ' + response.statusCode.toString());
    }
  }
}