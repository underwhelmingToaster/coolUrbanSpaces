import 'package:cool_urban_spaces/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              loginView(context),
              registerProfile(context),
              changeProfile(context),
            ],
          ),
          appBar: AppBar(
            title: Text("Profile"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Login",),
                Tab(text: "Register",),
                Tab(text: "Edit Profile"),
              ],
            ),
          ),
        )
    );
  }


  Widget loginView(BuildContext context){
    ProfileController profileController = Provider.of<ProfileController>(context);
    return SafeArea(child: ListView(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username"),
                          TextFormField(
                            maxLength: 20,
                            onChanged: (value) {
                              profileController.username = value;
                            },
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password"),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (value) {
                              profileController.password = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    key: Key("Submit Profile-Form"),
                    onPressed: () {
                      if(profileController.login()){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile details changed')));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password incorrect or fields empty'), backgroundColor: Colors.red));
                      }
                    },
                    child: Text("Login"),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }


  Widget registerProfile(BuildContext context){
    ProfileController profileController = Provider.of<ProfileController>(context);
    return SafeArea(
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Username"),
                            TextFormField(
                              maxLength: 20,
                              onChanged: (value) {
                                profileController.username = value;
                                },
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Password"),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) {
                                profileController.newpassword = value;
                              },
                            ),
                          ),
                          Text("Repeat Password"),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) {
                                profileController.repeatNewPassword = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      key: Key("Submit Profile-Form"),
                      onPressed: () {
                        if(profileController.register()){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile details changed')));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password incorrect or fields empty'), backgroundColor: Colors.red));
                        }
                      },
                      child: Text("Register"),
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }

  Widget changeProfile(BuildContext context){
    ProfileController profileController = Provider.of<ProfileController>(context);

    return SafeArea(
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Username"),
                            TextFormField(
                              maxLength: 20,
                              onChanged: (value) {
                                profileController.username = value;
                                },
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Password"),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) {
                                profileController.password = value;
                              },
                            ),
                          ),
                          Text("New password"),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) {
                                profileController.newpassword = value;
                              },
                            ),
                          ),
                          Text("Repeat new password"),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) {
                                profileController.repeatNewPassword = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      key: Key("Submit Profile-Form"),
                      onPressed: () {
                        if(profileController.changeProfile()){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile details changed')));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password incorrect or fields empty'), backgroundColor: Colors.red));
                        }
                      },
                      child: Text("Update profile"),
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}