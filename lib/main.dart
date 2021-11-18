import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/chat_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/profile_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/controller/tutorial_controller.dart';
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
import 'package:simple_tooltip/simple_tooltip.dart';

import 'view/widgets/utils_widget.dart';

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
          ChangeNotifierProvider(create: (_) => TutorialController()),
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
  bool _inital = true;

  @override
  Widget build(BuildContext context) {
    MapDataController mapDataController =
        Provider.of<MapDataController>(context);
    AddSuggestionController suggestionController =
        Provider.of<AddSuggestionController>(context);
    ProfileController profileController =
        Provider.of<ProfileController>(context);
    TutorialController tutorialController =
        Provider.of<TutorialController>(context);

    if (_inital) {
      tutorialController.check();
      _inital = false;
    }

    //tutorial

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(profileController.username),
                accountEmail: Text(""),
                currentAccountPicture:
                    Image.asset("assets/images/Coolcity.png"),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                otherAccountsPictures: [
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsView()));
                      },
                      splashColor: Colors.grey)
                ],
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: ToolTip(
                  child: const Text('Map'),
                  text: "Here you can return to the main map. [Click me]",
                  show: tutorialController.menuCounter == 1,
                  onTap: () => tutorialController.menuCounter--,
                  direction: TooltipDirection.right,
                  offset: -70,
                  fontSize: 10,
                ),
                onTap: () {
                  if (tutorialController.menuCounter == 1) {
                    tutorialController.menuCounter--;
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: ToolTip(
                  child: const Text('Browse'),
                  text:
                      "Here you can browse through all available suggestions. [Click me]",
                  show: tutorialController.menuCounter == 3,
                  onTap: () => tutorialController.menuCounter--,
                  direction: TooltipDirection.right,
                  offset: -70,
                  fontSize: 10,
                ),
                onTap: () {
                  if (tutorialController.menuCounter == 3) {
                    tutorialController.menuCounter--;
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BrowsingView()));
                },
              ),
              ListTile(
                leading: Icon(Icons.whatshot),
                title: ToolTip(
                  child: const Text('Supported by me'),
                  text:
                      "Here you can view all the suggestions you are currently supporting. [Click me]",
                  show: tutorialController.menuCounter == 2,
                  onTap: () => tutorialController.menuCounter--,
                  direction: TooltipDirection.down,
                  offset: 10,
                  fontSize: 10,
                ),
                onTap: () {
                  if (tutorialController.menuCounter == 2) {
                    tutorialController.menuCounter--;
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SupportView()));
                },
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddSuggestionView()));
          },
          child: Icon(Icons.add),
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
          nonRotatedChildren: [
            Visibility(
              visible: tutorialController.showCreateNotice,
              child: Container(
                color: Colors.white60,
                child: Center(
                  child: ToolTip(
                      child: ElevatedButton(
                          child: Text("Get Started"),
                          onPressed: () {
                            tutorialController.showCreateNotice = false;
                            mapDataController.updateMarkers();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context).primaryColor))),
                      show: tutorialController.showCreateNotice,
                      text:
                          "To create a new suggestion press on a desired location for at least 2 seconds."),
                ),
              ),
            ),
          ],
        ));
  }
}
