import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/model/message.dart';
import 'package:cool_urban_spaces/view/info_suggestion_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

/// Is the Provider Class which is responsible for the chat in [InfoSuggestionView]
class ChatController extends ChangeNotifier {
  List<Message> _activeMessages = [];
  final String webSocketURL = "wss://localhost:80";
  late WebSocketChannel channel;

  int _formerId = -1;

  /// connects to Websocket
  ChatController() {
    channel = WebSocketChannel.connect(
      Uri.parse(webSocketURL),
    );
  }

  List<Message> get activeMessages => _activeMessages;

  /// Send [TextMessage] to websocket and add to local cache.
  /// Notifies listeners
  void sendMessage(TextMessage message) {
    _activeMessages.add(message);
    channel.sink.add(MessageModel.fromMessage(message));
    notifyListeners();
  }

  /// connects to a different websocket identified by [id]
  void changeWebSocketChannel(int id) {
    if (_formerId != id) {
      _formerId = id;
      _activeMessages = [];
      updateMessages(
        id,
      );

      channel.sink.close(status.goingAway);

      if (id >= 0) {
        Uri uri = Uri.parse(webSocketURL + "/" + id.toString());
        channel = WebSocketChannel.connect(uri);

        channel.stream.listen((message) {
          if (message is MessageModel) {
            _activeMessages.add(message.toMessage());
          } else {
            throw ArgumentError("Result from websocket was invalid");
          }
        });
        notifyListeners();
        print("Listening to :" + uri.toString());
      }
    }
  }

  /// Loads all messages that are stored in the db and adds them to the local cache.
  void updateMessages(int id, [Function? whenDone]) {
    Future<List<MessageModel>> messages =
        DataProvider.dataProvider.getAllMessages(id);
    messages.then((value) => {
          value.forEach((element) {
            if (!_activeMessages.contains(element)) {
              _activeMessages.add(element.toMessage());
            }
          }),
          notifyListeners(),
          whenDone
        });
  }
}
