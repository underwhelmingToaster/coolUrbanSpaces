/// Stores the different ways the suggestions can be sorted.
enum SortingTypes { NAME, ID, TYPE }

/// Utility Class that provides utility methods for the [SortingTypes] Enum.
class SortingType {
  /// Converts a string to [SortingTypes] enum.
  static SortingTypes stringToEnum(String input) {
    switch (input) {
      case "Name":
        return SortingTypes.NAME;

      case "Id":
        return SortingTypes.ID;

      case "Type":
        return SortingTypes.TYPE;

      default:
        return SortingTypes.NAME;
    }
  }

  // TODO: Is there a better way to achieve this? Maybe a static list?
  /// Converts a [SortingTypes] enum to a string
  static String enumToString(SortingTypes type) {
    switch (type) {
      case SortingTypes.TYPE:
        return "Type";

      case SortingTypes.NAME:
        return "Name";

      case SortingTypes.ID:
        return "Id";
    }
  }

  /// Returns [SortingTypes] as a string [List]
  static List<String> sortingTypesStringList() {
    List<String> list = [];
    SortingTypes.values.forEach((element) {
      list.add(enumToString(element));
    });
    return list;
  }
}
