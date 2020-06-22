import 'package:flutter/material.dart';
import 'package:skive/page/login_web.dart';
import 'package:skive/page/page.dart';
import 'package:skive/page/register_web.dart';
import 'package:skive/storage/jwt_web.dart';
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
        title: appBarTitle('SKIVE', this),
        actions: (() => currentJwt == null
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
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserCenterPage())),
                ),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    logoutJwt();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
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
