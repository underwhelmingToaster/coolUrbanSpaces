import 'dart:async';

import 'package:cool_urban_spaces/view/urbanMapView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'Controller/markerController.dart';
import 'api/suggestionManager.dart';
import 'fragments/addSuggestion.dart' as addSuggestion;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_) => MarkerController()),
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
    MarkerController marker = Provider.of<MarkerController>(context);
    const interval = const Duration(seconds: 30);

    reloadDataScheduler(interval, marker);

    return Scaffold(
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => addSuggestion.StatefulAddSuggestionFragment()));
          },
        child: const Icon(Icons.add),
      ),
      body: new UrbanMapView()
    );
  }

  void reloadDataScheduler(var interval, MarkerController controller){
    SuggestionManager.formatSuggestions().then((value) => controller.markerList = value);
    Timer.periodic(interval, (Timer timer) {
      SuggestionManager.formatSuggestions().then((value) => controller.markerList = value);
    });
  }
}


