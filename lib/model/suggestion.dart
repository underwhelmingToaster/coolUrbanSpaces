
class Suggestion {

  late String title;
  late String text;
  late int type;
  late double lat;
  late double lng;

  Suggestion(this.title, this.text, this.type, this.lat, this.lng);

  Suggestion.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      text = json['text'],
      type = json['type'],
      lat = json['lat'],
      lng = json['lng'];
}