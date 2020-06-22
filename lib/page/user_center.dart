import 'package:flutter/material.dart';
import 'package:skive/page/home_web.dart';
import 'package:skive/page/page.dart';
import 'package:skive/storage/jwt_client.dart'
    if (dart.library.js) 'package:skive/storage/jwt_web.dart';

class UserCenterPage extends StatefulWidget {
  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle("USER CENTER", this),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logoutJwt();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'What to display?',
            ),
          ],
        ),
      ),
    );
  }
}
