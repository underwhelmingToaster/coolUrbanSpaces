import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';

class LocalDataProvider implements DataProvider{

  static final LocalDataProvider _requestData = LocalDataProvider._internal();

  factory LocalDataProvider(){
    return _requestData;
  }

  LocalDataProvider._internal();

  List<Suggestion> _localSuggestions = [];

  @override
  Future<List<Suggestion>> getAllSuggestions() async{
    return _localSuggestions;
  }

  @override
  Future<void> postSuggestion(Suggestion suggestion) async{
    _localSuggestions.add(suggestion);
  }

  @override
  Future<Suggestion> getSuggestion(int id) async{
    Suggestion suggestion = _localSuggestions.first;
    _localSuggestions.forEach((element) {
      if(element.id == id){
        suggestion = element;
      }
    });
    return suggestion;
  }
}