import 'dart:async';

import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/chat_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/profile_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/view/add_suggestion_view.dart';
import 'package:cool_urban_spaces/view/browsing_view.dart';
import 'package:cool_urban_spaces/view/info_suggestion_view.dart';
import 'package:cool_urban_spaces/view/profile_view.dart';
import 'package:cool_urban_spaces/view/settings_view.dart';
import 'package:cool_urban_spaces/view/supported_view.dart';
import 'package:cool_urban_spaces/view/widgets/urban_map_widget.dart';
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
          ChangeNotifierProvider(create: (_) => SettingsController()),
          ChangeNotifierProvider(create: (_) => ProfileController()),
          ChangeNotifierProvider(create: (_) => ChatController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cool Urban',
          home: StatefulMapFragment(),
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(0xff92d396),
            accentColor: Colors.green,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
        ));
  }
}

class StatefulMapFragment extends StatefulWidget {
  @override
  _MapFragment createState() => _MapFragment();
}

class _MapFragment extends State<StatefulMapFragment> {
  @override
  Widget build(BuildContext context) {
    MapDataController mapDataController =
        Provider.of<MapDataController>(context);
    AddSuggestionController suggestionController =
        Provider.of<AddSuggestionController>(context);

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(""),
                  accountEmail: Text(""),
                currentAccountPicture: Image.asset("assets/images/Coolcity.png"),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                otherAccountsPictures: [
                  IconButton(icon: Icon(Icons.settings), onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsView()));},
                      splashColor: Colors.grey)
                ],
              ),
              ListTile(
                title: const Text('Map'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Browse'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BrowsingView())),
              ),
              ListTile(
                title: const Text('Supported by me'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SupportView())),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileView())),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ));
            },
          ),
          title: const Text('Cool Urban Spaces'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "addButton",
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddSuggestionView()));
          },
          child: const Icon(Icons.add),
        ),
        body: new UrbanMapView(
          displayedMarkers: mapDataController.availableMarkers,
          onLongPress: (lon, lat, _context) {
            suggestionController.setLocation(lat, lon);

            Navigator.push(_context,
                MaterialPageRoute(builder: (context) => AddSuggestionView()));
          },
          onTab: (lon, lat, _context) {
            suggestionController.lat = lat;
            suggestionController.lon = lon;
          },
          onMarkerTab: (value, _context) {
            int id = mapDataController.cleanUpKey(value.key as Key);
            mapDataController.setSelectedMarkerToId(id);
            Navigator.push(_context,
                MaterialPageRoute(builder: (_context) => InfoSuggestionView()));
          },
        ));
  }
}
