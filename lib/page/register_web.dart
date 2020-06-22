import 'package:flutter/material.dart';
import 'package:skive/page/home_web.dart';
import 'package:skive/page/login_web.dart';
import 'package:skive/page/page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle("REGISTER", this),
        actions: [
          FlatButton(
            child: Text('Login'),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LogInPage())),
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage())),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'What to display',
            ),
          ],
        ),
      ),
    );
  }
}
