import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class UrbanMapView extends StatelessWidget {
  late bool isInteractable;
  late LatLng startingLocation;
  late double startZoom;

  late List<Marker> displayedMarkers;
  late List<Widget>? nonRotatedChildren;

  late Function? onLongPress;
  late Function? onTab;
  late Function? onMarkerTab;

  MapController mc = new MapController();

  UrbanMapView({
    required this.displayedMarkers,
    this.isInteractable = true,
    this.startZoom = 15.0,
    LatLng? startLocation,
    this.onLongPress,
    this.onTab,
    this.onMarkerTab,
    this.nonRotatedChildren,
  }) {
    if (startLocation == null) {
      startLocation = new LatLng(47.2246, 8.8173);
    }
    startingLocation = startLocation;
  }


  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: new MapOptions(
        center: startingLocation,
        zoom: startZoom,
        maxZoom: 19,
        minZoom: 8,
        controller: mc,
        plugins: [
          LocationMarkerPlugin(),
          MarkerClusterPlugin(),
        ],
        onTap: (a, point) {
          if (onTab != null) {
            onTab!(point.longitude, point.latitude, context);
          }
        },
        onLongPress: (a, point) {
          if (onLongPress != null) {
            onLongPress!(point.longitude, point.latitude, context);
          }
        },
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "http://tile.osm.ch/osm-swiss-style/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        LocationMarkerLayerOptions(),
        MarkerClusterLayerOptions(
          markers: this.displayedMarkers,
          onMarkerTap: (value) {
            if (onMarkerTab != null) {
              onMarkerTab!(value, context);
            }
          },
          builder: (BuildContext context, List<Marker> markers) {
            return FloatingActionButton(
                child: Text(markers.length.toString()), onPressed: () {});
          },
        ),
      ],
      nonRotatedChildren: nonRotatedChildren ?? [],
    );
  }
}
