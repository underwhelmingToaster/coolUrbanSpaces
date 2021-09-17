import 'package:cool_urban_spaces/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatController extends ChangeNotifier{
  List<Message> _activeMessages = [];
  final String webSocketURL = "wss://notawebsocket.ch";
  late WebSocketChannel channel;

  int _formerId = -1;

  ChatController(){
    channel = WebSocketChannel.connect(
      Uri.parse(webSocketURL),
    );
  }

  List<Message> get activeMessages => _activeMessages;

  void sendMessage(TextMessage message) {
    _activeMessages.add(message);
    channel.sink.add(MessageModel.fromMessage(message));
    notifyListeners();
  }

  void changeWebSocketChannel(int id){

    if(_formerId != id) {
      _formerId = id;
      channel.sink.close(status.goingAway);
      if(id >= 0){
        Uri uri = Uri.parse(webSocketURL + "/" + id.toString());
        channel = WebSocketChannel.connect(uri);
        print("Listening to :" + uri.toString());
      }
    }
  }

  void updateMessages(){
    channel.stream.listen((message) {
      if(message is MessageModel){
        _activeMessages.add(message.toMessage());
      }else{
        // TODO: throw exception (invalid result from websocket)
      }
    });
    notifyListeners();
  }
}