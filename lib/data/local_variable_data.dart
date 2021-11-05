import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/model/message.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';

class LocalDataProvider implements DataProvider{

  static final LocalDataProvider _requestData = LocalDataProvider._internal();

  factory LocalDataProvider(){
    return _requestData;
  }

  LocalDataProvider._internal();

  List<SuggestionModel> _localSuggestions = [];
  List<MessageModel> _messages = [];

  @override
  Future<List<SuggestionModel>> getAllSuggestions() async{
    return _localSuggestions;
  }

  @override
  Future<List<SuggestionModel>> getSupportedSuggestions(int id) async {
    return _localSuggestions;
  }

  @override
  Future<void> postSuggestion(SuggestionModel suggestion) async{
    if(suggestion.id == null){
      suggestion.id = _localSuggestions.length;
    }
    _localSuggestions.add(suggestion);
  }

  @override
  Future<SuggestionModel> getSuggestion(int id) async{
    SuggestionModel suggestion = _localSuggestions.first;
    _localSuggestions.forEach((element) {
      if(element.id == id){
        suggestion = element;
      }
    });
    return suggestion;
  }

  @override
  Future<List<MessageModel>> getAllMessages(int chatId) async {
    return _messages;
  }

  @override
  Future<void> postMessage(MessageModel message) async {
    _messages.add(message);
  }
}