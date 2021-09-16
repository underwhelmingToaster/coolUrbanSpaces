import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageModel{
  String uuid;
  late String authorName;
  late String text;

  MessageModel(this.authorName, this.text, this.uuid);


  MessageModel.fromJson(Map<String, dynamic> json):
        uuid = json['uuid'],
        authorName = json['authorName'], //TODO: change to get User
        text = json['text'];

  Map<String, dynamic> toJson() => {
    'uuid' : uuid,
    'text' : text,
    'authorName' : authorName,
  };

  types.TextMessage toMessage() {
    return types.TextMessage(id: this.uuid, author: types.User(id: authorName), text: this.text);
  }
}