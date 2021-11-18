import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';

/// This enum stores all the different suggestion types
enum SuggestionTypes { GENERAL, SHADING, SEATING, GARDENING, SOCIAL, WATER, PLANTS  }

/// Utility class for [SuggestionTypes]
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

  /// Converts [SuggestionTypes] to [String]
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

  /// Returns the relative [SuggestionTypes] to its position in [Enum.values]
  static SuggestionTypes intToEnum(int i){
    return SuggestionTypes.values[i];
  }

  /// Converts a [int] to [SuggestionTypes] and returns it as a [string]
  static String intToString(int i){
    return enumToString(intToEnum(i));
  }

  /// Returns [SuggestionTypes] as a string [List]
  static List<String> sortingTypesStringList() {
    List<String> list = [];
    SuggestionTypes.values.forEach((element) {
      list.add(enumToString(element));
    });
    return list;
  }
}