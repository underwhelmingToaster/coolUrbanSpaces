import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatController extends ChangeNotifier{
  List<Message> _activeMessages = [];

  List<Message> get activeMessages => _activeMessages;

  void sendMessage(Message message) {
    // TODO: Load messages first?
    _activeMessages.add(message);
    notifyListeners();
  }
}