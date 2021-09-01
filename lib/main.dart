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

//double lastLatTap = 0.0;
//double lastLngTap = 0.0;

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
  //var mc = new MapController();

  @override
  Widget build(BuildContext context) {
    MarkerController marker = Provider.of<MarkerController>(context);
    const interval = const Duration(seconds: 30);

    reloadDataScheduler(interval, marker);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/Coolcity.png",
          ),
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

  /*FlutterMap mapComponent(){
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(51.5, -0.09),
        zoom: 13.0,
        controller: mc,
        plugins: [
          MarkerClusterPlugin()
        ],
        onTap: (point) {
          lastLatTap = point.latitude;
          lastLngTap = point.longitude;
        },
        onLongPress: (point) {
          point.latitude = lastLngTap;
          point.longitude = lastLngTap;
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => addSuggestion.StatefulAddSuggestionFragment()));
        },
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],

        ),
        MarkerClusterLayerOptions(
          markers: marker.markerList,
          onMarkerTap: (value) {
            var controller = Provider.of<MarkerController>(context);
            controller.selectedMarker = value;
          },
          builder: (BuildContext context, List<Marker> markers) {
            return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: () {
                  // TODO au hilfe zämme mit em andere todo
                }
            );
          },
        ),
      ],
    );
  }*/

  void reloadDataScheduler(var interval, MarkerController controller){
    Timer.periodic(interval, (Timer timer) {
      SuggestionManager.formatSuggestions().then((value) => controller.markerList = value);
    });
  }
}


