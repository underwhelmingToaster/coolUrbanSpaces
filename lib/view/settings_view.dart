import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Settings"),
          ),
          body: ListView(
            children: [
              Card(
                child: ListTile(
                  title: Text("EXAMPLE"),
                  trailing: Switch(
                    value: settingsController.exampleSwitch,
                    onChanged: (newValue) {
                      settingsController.exampleSwitch = newValue;
                    },
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
