enum SortingTypes{
  NAME,
  ID,
  TYPE
}

class SortingType {
  static SortingTypes stringToEnum(String input){
    switch(input){
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


  static String enumToString(SortingTypes type){
    switch(type){
    case SortingTypes.TYPE:
    return "Type";

    case SortingTypes.NAME:
    return "Name";

    case SortingTypes.ID:
    return "Id";
    }
  }

  static List<String> sortingTypesStringList(){
    List<String> list = [];
    SortingTypes.values.forEach((element) { list.add(enumToString(element)); });
    return list;
  }
}