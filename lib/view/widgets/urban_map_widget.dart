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
  late Function? onLongPress;
  late Function? onTab;
  late Function? onMarkerTab;

  MapController mc = new MapController();

  UrbanMapView({
    required this.displayedMarkers,
    this.isInteractable = true,
    this.startZoom = 13.0,
    LatLng? startLocation,
    this.onLongPress,
    this.onTab,
    this.onMarkerTab,
  }) {
    if (startLocation == null) {
      startLocation = new LatLng(47.0, 8.0);
    }
    startingLocation = startLocation;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: new MapOptions(
        center: startingLocation,
        zoom: startZoom,
        controller: mc,
        plugins: [
          MarkerClusterPlugin(),
          LocationMarkerPlugin(),
        ],
        onTap: (point) {
          if (onTab != null) {
            onTab!(point.longitude, point.latitude, context);
          }
        },
        onLongPress: (point) {
          if (onLongPress != null) {
            onLongPress!(point.longitude, point.latitude, context);
          }
        },
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
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
        LocationMarkerLayerOptions(
          marker: DefaultLocationMarker(
            color: Colors.blue,
          )
        ),
      ],
    );
  }
}
