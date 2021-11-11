import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class UrbanMapView extends StatelessWidget{

  late bool isInteractable;
  late LatLng startingLocation;
  late double startZoom;
  late List<Marker>? displayedMarkers;
  late Future<List<Marker>>? displayedMarkersFuture;
  late Function? onLongPress;
  late Function? onTab;
  late Function? onMarkerTab;

  MapController mc = new MapController();

  UrbanMapView(
      {
        this.displayedMarkers,
        this.displayedMarkersFuture,
        this.isInteractable = true,
        this.startZoom = 13.0,
        LatLng? startLocation,
        this.onLongPress,
        this.onTab,
        this.onMarkerTab,
      }
  )
  {
    assert((displayedMarkers != null || displayedMarkersFuture != null), "One of the parameters must be provided",);
    if(startLocation==null){
      startLocation = new LatLng(47.0, 8.0);
    }
    startingLocation = startLocation;
  }

  @override
  Widget build(BuildContext context) {
    if(displayedMarkersFuture != null){
      return FutureBuilder<List<Marker>>(
          future: this.displayedMarkersFuture,
          builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                return mapWithMarkers(context, []);
              default:
                if(snapshot.hasError){
                  return Text("Something went wrong :(");
                }else{
                  return mapWithMarkers(context, snapshot.data!);
                }
            }
          }
      );
    }else{
      return mapWithMarkers(context, this.displayedMarkers!);
    }
  }

  Widget mapWithMarkers(BuildContext context, List<Marker> markers){
    return FlutterMap(
      options:
      new MapOptions(
        center: startingLocation,
        zoom: startZoom,
        controller: mc,
        plugins: [
          MarkerClusterPlugin(),
        ],
        onTap: (point) {
          if(onTab!=null){
            onTab!(point.longitude, point.latitude, context);
          }
        },
        onLongPress: (point) {
          if(onLongPress!=null){
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
          markers: markers,
          onMarkerTap: (value) {
            if(onMarkerTab!=null){
              onMarkerTab!(value, context);
            }
          },
          builder: (BuildContext context, List<Marker> markers) {
            return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: () { }
            );
          },
        ),
      ],
    );
  }


}