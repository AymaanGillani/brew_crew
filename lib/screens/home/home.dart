import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("Brew Crew"),
          elevation: 0.0,
          actions: <Widget>[
            ButtonTheme(
              padding: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 3.0), //adds padding inside the button
              materialTapTargetSize: MaterialTapTargetSize
                  .shrinkWrap, //limits the touch area to the button area
              minWidth: 0, //wraps child's width
              height: 0, //wraps child's height
              child: FlatButton.icon(
                onPressed: _showSettingsPanel,
                icon: Icon(Icons.settings),
                label: Text(''),
              ), //your original button
            ),
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.exit_to_app),
              label: Text("Logout"),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
