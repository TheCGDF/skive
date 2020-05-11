import 'package:flutter/material.dart';
import 'package:skive/page/login.dart';
import 'package:skive/page/register.dart';
import 'package:skive/storage/storage.dart'
if (dart.library.js) 'package:skive/storage/storage_web.dart';
import 'package:skive/page/user_center.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SKIVE"),
        actions: (() => jwt == null
            ? [
                FlatButton(
                  child: Text('Register'),
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpPage())),
                ),
                FlatButton(
                  child: Text('Login'),
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LogInPage())),
                ),
              ]
            : [
                FlatButton(
                  child: Text('User center'),
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => UserCenterPage())),
                )
              ]).call(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'What to show?',
            ),
          ],
        ),
      ),
    );
  }
}
