import 'package:cool_urban_spaces/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Provider.of<ProfileController>(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("Username"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Password"),
            ),
          )
        ],
      )
    )
    );
  }
}