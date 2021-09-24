import 'package:cool_urban_spaces/data/local_variable_data.dart';
import 'package:cool_urban_spaces/model/message.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';


abstract class DataProvider{

  static DataProvider dataProvider = LocalDataProvider();

  Future<List<SugestionModel>> getAllSuggestions();

  Future<SugestionModel> getSuggestion(int id);

  Future<void> postSuggestion(SugestionModel suggestion);

  Future<List<MessageModel>> getMessage(int chatId);

  Future<void> postMessage(MessageModel message);

}