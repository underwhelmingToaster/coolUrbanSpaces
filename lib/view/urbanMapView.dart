import 'package:cool_urban_spaces/Controller/markerController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:cool_urban_spaces/fragments/addSuggestion.dart' as addSuggestion;

class UrbanMapView extends StatelessWidget{

  var mc = new MapController();

  static double lastLatTap = 0.0;
  static double lastLngTap = 0.0;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<MarkerController>(context);
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
          markers: controller.markerList,
          onMarkerTap: (value) {

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
  }
}