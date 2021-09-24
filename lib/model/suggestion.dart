class SugestionModel {

  int? id;
  late String title;
  late String text;
  late int type;
  late double lat;
  late double lng;

  SugestionModel(this.title, this.text, this.type, this.lat, this.lng, [this.id]);

  SugestionModel.fromJson(Map<String, dynamic> json):
      title = json['title'],
      text = json['description'],
      type = json['type'],
      lat = json['lat'],
      lng = json['lon'],
      id = json['id'];

  Map<String, dynamic> toJson() => {
    'title' : title,
    'description' : text,
    'type' : type,
    'lat' : lat,
    'lon' : lng,
  };
}