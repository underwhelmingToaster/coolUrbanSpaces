import 'dart:convert';
import 'dart:async';

import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/model/message.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:http/http.dart' as http;

class ApiRequestData implements DataProvider{

  static final ApiRequestData _requestData = ApiRequestData._internal();

  static final String BASE_URL = "localhost:80";

  factory ApiRequestData(){
    return _requestData;
  }

  ApiRequestData._internal();

  @override
  Future<List<SuggestionModel>> getAllSuggestions() async {
    final response = await http.get(Uri.http(BASE_URL,'/api/suggestion/all'));

    if(response.statusCode == 200) {
      List<dynamic> suggestionList = jsonDecode(response.body);
      return suggestionList.map((dict) => SuggestionModel.fromJson(dict)).toList();

    }else{
      throw Exception('Failed to load all suggestions. Status: ' + response.statusCode.toString());
    }
  }

  @override
  Future<SuggestionModel> getSuggestion(int id) async {
    final response = await http.get(Uri.http(BASE_URL, '/api/suggestion/' + id.toString()));
    if(response.statusCode == 200){
      return SuggestionModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load single suggestion. Status: ' + response.statusCode.toString());
    }
  }

  @override
  Future<void> postSuggestion(SuggestionModel suggestion) async {
    final response = await http.post(Uri.http(BASE_URL, '/api/suggestion/add'), body: jsonEncode(suggestion.toJson()), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200){
      return;
    }else{
      throw Exception('Failed to post new Suggestion. Status: ' + response.statusCode.toString());
    }
  }

  @override
  Future<List<MessageModel>> getAllMessages(int chatId) async {
    final response = await http.get(Uri.http(BASE_URL, '/api/message/all'));

    if(response.statusCode == 200) {
      List<dynamic> messageList = jsonDecode(response.body);
      return messageList.map((dict) => MessageModel.fromJson(dict)).toList();

    }else{
      throw Exception('Failed to load all suggestions. Status: ' + response.statusCode.toString());
    }
  }

  @override
  Future<void> postMessage(MessageModel message) async {
    final response = await http.post(Uri.http(BASE_URL, '/api/message/add'), body: jsonEncode(message.toJson()), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200){
      return;
    }else{
      throw Exception('Failed to post new Suggestion. Status: ' + response.statusCode.toString());
    }
  }

  @override
  Future<List<int>> getSupported(int userId) {
    throw UnimplementedError();
  }


}