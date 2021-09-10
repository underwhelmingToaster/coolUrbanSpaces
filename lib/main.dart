import 'dart:async';

import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/view/add_suggestion_view.dart';
import 'package:cool_urban_spaces/view/urban_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddSuggestionController()),
        ChangeNotifierProvider(create: (_) => MapDataController()),
      ],
        child: MaterialApp(
          title: 'Cool Urban',
          home: StatefulMapFragment(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        )
    );
  }
}

class StatefulMapFragment extends StatefulWidget {
  @override
  _MapFragment createState() => _MapFragment();
}

class _MapFragment extends State<StatefulMapFragment> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('CoolUrbanSpaces'),),
            ListTile(
              title: const Text('Map'),
            ),
            ListTile(
              title: const Text('Browse'),
            ),
            ListTile(
              title: const Text('Supported'),
            ),
            ListTile(
              title: const Text('Profile'),
            ),
            ListTile(
              title: const Text('Settings'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/Coolcity.png",),
        ),
        title: const Text('Cool Urban Spaces'),
          backgroundColor: Color(0xff92d396
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Show Menu',
              onPressed: () {
                // TODO menu
              },
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "addButton",
        backgroundColor: Color(0xff92d396),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddSuggestionView()));
          },
        child: const Icon(Icons.add),
      ),
      body: new UrbanMapView()
    );
  }

  /*void reloadDataScheduler(var interval, MarkerController controller){
    if(!started) {
      started = true;
      SuggestionManager.formatSuggestions().((value) =>
      controller.markerList = value);
      Timer.periodic(interval, (Timer timer) {
        SuggestionManager.formatSuggestions().then((value) =>
        controller.markerList = value);
      });
    }
  }*/
}


