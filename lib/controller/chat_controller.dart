import 'package:cool_urban_spaces/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends ChangeNotifier{
  List<Message> _activeMessages = [];
  final String webSocketURL = "wss://notawebsocket.ch";


  List<Message> get activeMessages => _activeMessages;

  void sendMessage(Message message) {
    // TODO: Load messages first?
    _activeMessages.add(message);
    notifyListeners();
  }

  void updateMessages(){
    final channel = WebSocketChannel.connect(
      Uri.parse(webSocketURL),
    );

    channel.stream.listen((message) {
      if(message is MessageModel){
        _activeMessages.add(message.toMessage());
      }
    });
    notifyListeners();
  }
}