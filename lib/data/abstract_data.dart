import 'package:cool_urban_spaces/data/local_variable_data.dart';
import 'package:cool_urban_spaces/model/message.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';


abstract class DataProvider{

  static DataProvider dataProvider = LocalDataProvider();

  Future<List<SuggestionModel>> getAllSuggestions();

  Future<SuggestionModel> getSuggestion(int id);

  Future<List<SuggestionModel>> getSupportedSuggestions(int id);

  Future<void> postSuggestion(SuggestionModel suggestion);

  Future<List<MessageModel>> getAllMessages(int chatId);

  Future<void> postMessage(MessageModel message);
}