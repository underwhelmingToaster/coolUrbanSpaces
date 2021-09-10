import 'dart:convert';

class User {
  int? id;
  late String name;
  late String pwdHash;

  User(this.name, this.pwdHash, [this.id]);

  User.fromJson(Map<String, dynamic> json)
      :
        name = json["name"],
        pwdHash = json["pwdHash"],
        id = json["id"];

  Map<String, dynamic> toJson() => {
    'name' : name,
    'pwdHash' : pwdHash,
    'id' : id,
  };
}

