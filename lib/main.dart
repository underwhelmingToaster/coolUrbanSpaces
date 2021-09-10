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
            brightness: Brightness.light,
            primaryColor: Color(0xff92d396),
            accentColor: Color(0xff92d396),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff92d396)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff92d396)),
              ),
            ),
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
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
        leading: Builder(builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Image.asset("assets/images/Coolcity.png"),
                iconSize: 50,
                onPressed: () => Scaffold.of(context).openDrawer(),
              )
          );},
        ),
        title: const Text('Cool Urban Spaces'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "addButton",
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddSuggestionView()));
          },
        child: const Icon(Icons.add),
      ),
      body: new UrbanMapView()
    );
  }
}


