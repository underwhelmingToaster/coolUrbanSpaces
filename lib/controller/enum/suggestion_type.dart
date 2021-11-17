enum SuggestionTypes { GENERAL, SHADING, SEATING, GARDENING, SOCIAL, WATER, PLANTS  }

class SuggestionType {
  static SuggestionTypes stringToEnum(String input) {
    switch (input) {
      case "General":
        return SuggestionTypes.GENERAL;

      case "Shading":
        return SuggestionTypes.SHADING;

      case "Seating":
        return SuggestionTypes.SEATING;

      case "Gardening":
        return SuggestionTypes.GARDENING;

      case "Social":
        return SuggestionTypes.SOCIAL;

      case "Water":
        return SuggestionTypes.WATER;

      case "Plants":
        return SuggestionTypes.PLANTS;

      default:
        return SuggestionTypes.GENERAL;
    }
  }

  static String enumToString(SuggestionTypes type) {
    switch (type) {
      case SuggestionTypes.GENERAL:
        return "General";

      case SuggestionTypes.SHADING:
        return "Shading";

      case SuggestionTypes.SEATING:
        return "Seating";

      case SuggestionTypes.GARDENING:
        return "Gardening";

      case SuggestionTypes.SOCIAL:
        return "Social";

      case SuggestionTypes.WATER:
        return "Water";

      case SuggestionTypes.PLANTS:
        return "Plants";

      default:
        return "General";
    }
  }

  static SuggestionTypes intToEnum(int i){
    return SuggestionTypes.values[i];
  }

  static String intToString(int i){
    return enumToString(intToEnum(i));
  }

  static List<String> sortingTypesStringList() {
    List<String> list = [];
    SuggestionTypes.values.forEach((element) {
      list.add(enumToString(element));
    });
    return list;
  }
}