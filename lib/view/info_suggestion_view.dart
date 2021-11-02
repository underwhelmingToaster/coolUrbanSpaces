import 'package:cool_urban_spaces/controller/chat_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/profile_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/urban_map_view.dart';
import 'package:cool_urban_spaces/view/utils_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class InfoSuggestionView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Suggestion"),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.info)),
                  Tab(icon: Icon(Icons.chat_bubble))
                ],
              ),
            ),
            body: SafeArea(
                child: TabBarView(
                  children: [
                    overviewTab(context),
                    chatTab(context),
                  ],
                )
            )
        )
    );
  }

  Widget overviewTab(BuildContext context){
    MapDataController mapDataController = Provider.of<MapDataController>(context);

    String title = "";
    String desc = "";
    LatLng location = LatLng(0,0);
    Icon icon = Icon(Icons.warning, color: Colors.orange,);

    SuggestionModel? suggestion= mapDataController.lastSelect;

    if(suggestion!=null){
      title = suggestion.title;
      desc = suggestion.text;
      icon = mapDataController.getMarkerIcon(suggestion);
      location = LatLng(suggestion.lat, suggestion.lng);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
              child: UrbanMapView(
                displayedMarkers: mapDataController.availableMarkers,
                isInteractable: false,
                startLocation: location,
              ),
              height: 100,
            )
        ),
        NormalizedPadding(
            child: Row(
              children: [
                icon,
                Text(title, style: TextStyle(fontSize: 16),),
              ],
            ),
        ),
        Expanded(
          child: ListView(
            children: [
              Card(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child:Text(desc)
                  )
              )
            ],
          ),
        )
      ],
    );
  }

  Widget chatTab(BuildContext context){
    ChatController chatController = Provider.of<ChatController>(context);
    ProfileController profileController = Provider.of<ProfileController>(context);
    MapDataController suggestionController = Provider.of<MapDataController>(context);

    if(suggestionController.lastSelect != null) {
      int id = suggestionController.lastSelect!.id as int;
      chatController.changeWebSocketChannel(id);
    }

    types.User _user = types.User(id: profileController.username);
    List<types.Message> _messages = chatController.activeMessages;

    _messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    _messages = _messages.reversed.toList();

    return Chat(
        messages: _messages,
        onSendPressed: (message) => chatController.sendMessage(new types.TextMessage(
            author: _user,
            id: Uuid().v4(),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            text: message.text)),
        user: _user);
  }
}