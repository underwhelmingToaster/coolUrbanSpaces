import 'package:cool_urban_spaces/model/suggestion.dart';

abstract class DataProvider{

  Future<List<Suggestion>> getAllSuggestions();

  Future<Suggestion> getSuggestion(int id);

  Future<void> postSuggestion(Suggestion suggestion);

}