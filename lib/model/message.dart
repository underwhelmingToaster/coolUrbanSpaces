import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

/// Message Model
class MessageModel {
  late String uuid;
  late String authorName;
  late String text;
  late int createdAt;

  MessageModel(this.authorName, this.text, this.uuid, this.createdAt);

  MessageModel.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        authorName = json['authorName'],
        text = json['text'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'text': text,
        'authorName': authorName,
        'createdAt': createdAt,
      };

  /// Converts [MessageModel] to a [TextMessage]
  types.TextMessage toMessage() {
    return types.TextMessage(
        id: this.uuid,
        author: types.User(id: authorName),
        text: this.text,
        createdAt: this.createdAt);
  }

  /// Converts [TextMessage] to [MessageModel].
  MessageModel.fromMessage(types.TextMessage message) {
    this.uuid = message.id;
    this.authorName = message.author.id;
    this.text = message.text;
    this.createdAt = message.createdAt!;
  }
}
