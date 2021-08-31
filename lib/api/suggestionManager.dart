import 'package:latlong2/latlong.dart';

class SuggestionManager {
  List getSuggestions () {
    var suggestion1 = new Suggestion("titel 1", "text 1", "type 1", 51.1, -0.09);
    var suggestion2 = new Suggestion("titel 2", "text 2", "type 2", 51.2, -0.08);
    var suggestions = [suggestion1, suggestion2];
    return suggestions;
  }

}

class Suggestion {

  late String title;
  late String text;
  late String type;
  late double lat;
  late double long;

  Suggestion(this.title, this.text, this.type, this.lat, this.long);


}