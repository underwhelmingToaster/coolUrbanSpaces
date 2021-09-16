
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Provider.of<SettingsController>(context);

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("EXAMPLE"),
              trailing: Switch(
                value: settingsController.exampleSwitch,
                onChanged: (newValue) {settingsController.exampleSwitch = newValue;},
              ),
            ),
          ),
          Card(
            child: Row(
              children: [
                Text("Auto-refresh Chat"),
                Spacer(),
                Container(
                  child: Switch(
                      value: settingsController.automaticRefresh,
                      onChanged: (newValue) {
                        settingsController.automaticRefresh = newValue;
                      }),
                ),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Refresh rate"),
                          TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              settingsController.chatRefreshRate = int.parse(value);
                            },
                          ),
                        ]
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}