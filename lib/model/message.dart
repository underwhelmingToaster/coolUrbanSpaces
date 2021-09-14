import 'package:cool_urban_spaces/model/user.dart';

class MessageModel{
  String? uuid;
  late String authorName;
  late String text;

  MessageModel(this.authorName, this.text, [this.uuid]);


  MessageModel.fromJson(Map<String, dynamic> json):
        uuid = json['uuid'],
        authorName = json['authorName'], //TODO: change to get User
        text = json['text'];

  Map<String, dynamic> toJson() => {
    'uuid' : uuid,
    'text' : text,
    'authorName' : authorName,
  };
}