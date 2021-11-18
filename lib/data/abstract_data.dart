import 'package:cool_urban_spaces/data/api_request_data.dart';
import 'package:cool_urban_spaces/data/local_variable_data.dart';
import 'package:cool_urban_spaces/model/message.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';

/// abstract class to define the properties of all instances.
abstract class DataProvider {

  /// set the current Dataprovider implementation
  ///
  /// [LocalDataProvider] for local storage
  /// [ApiRequestData] for sending the data to webAPI (Backend)
  static DataProvider dataProvider = LocalDataProvider();

  Future<List<SuggestionModel>> getAllSuggestions();

  Future<SuggestionModel> getSuggestion(int id);

  Future<void> postSuggestion(SuggestionModel suggestion);

  Future<List<MessageModel>> getAllMessages(int chatId);

  Future<void> postMessage(MessageModel message);

  Future<List<int>> getSupported(int userId);

  Future<void> postSupport(int userId, int suggestionId);

  Future<void> deleteSupport(int userId, int suggestionId);
}
