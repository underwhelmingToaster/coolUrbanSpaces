import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/view/add_suggestion_view.dart';
import 'package:cool_urban_spaces/view/info_suggestion_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class UrbanMapView extends StatelessWidget{

  var mc = new MapController();

  static double lastLatTap = 0.0;
  static double lastLngTap = 0.0;

  @override
  Widget build(BuildContext context) {
    AddSuggestionController suggestionController = Provider.of<AddSuggestionController>(context);
    MapDataController mapDataController = Provider.of<MapDataController>(context);
    return FlutterMap(
          options: new MapOptions(
            center: new LatLng(47.0, 8.0),
            zoom: 13.0,
            controller: mc,
            plugins: [
              MarkerClusterPlugin(),
            ],
            onTap: (point) {
              suggestionController.lat = point.latitude;
              suggestionController.lon = point.longitude;
              },
            onLongPress: (point) {
              suggestionController.lat = point.latitude;
              suggestionController.lon = point.longitude;
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => AddSuggestionView()
                  )
              );
              },


          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),

            MarkerClusterLayerOptions(
              markers: mapDataController.availableMarkers,
              onMarkerTap: (value) {
                int id = mapDataController.cleanUpKey(value.key as Key);
                mapDataController.setSelectedMarkerToId(id);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => InfoSuggestionView()
                ));
                },
              builder: (BuildContext context, List<Marker> markers) {
                return FloatingActionButton(
                    child: Text(markers.length.toString()),
                    onPressed: () { }
                    );
                },
            ),
          ]
    );
  }
}