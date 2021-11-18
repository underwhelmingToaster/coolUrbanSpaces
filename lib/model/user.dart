/// User Model
class UserModel {
  int? id;
  late String name;
  late String pwdHash;

  UserModel(this.name, this.pwdHash, [this.id]);

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        pwdHash = json["pwdHash"],
        id = json["id"];

  Map<String, dynamic> toJson() => {
        'name': name,
        'pwdHash': pwdHash,
        'id': id,
      };
}
