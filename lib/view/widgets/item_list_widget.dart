import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/view/widgets/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemList extends StatelessWidget{

  late List<Widget> widgets;

  ItemList(this.widgets);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Provider.of<SettingsController>(context);

    return Column(
      children: [
        NormalizedPadding(
          child: Row(
            children: [
              Text("All Entries:"),
              Spacer(),
              DropdownButton(
                value: SortingType.enumToString(settingsController.browsingSort),
                onChanged: (String? newValue) {
                  settingsController.browsingSort = SortingType.stringToEnum(newValue!);
                },
                items: SortingType.sortingTypesStringList().map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView(
              children: widgets,
            )
        ),
      ],
    );
  }
}