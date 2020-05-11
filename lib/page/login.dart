import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:skive/page/home.dart';
import 'package:skive/page/page.dart';
import 'package:skive/page/register.dart';
import 'package:skive/page/user_center.dart';
import 'package:skive/storage/storage.dart'
    if (dart.library.js) 'package:skive/storage/storage_web.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _captchaController = TextEditingController();
  Image _captchaImage;
  String _captchaHashId;

  @override
  void initState() {
    refreshCaptcha();
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
        actions: [
          FlatButton(
            child: Text('Register'),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUpPage())),
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage())),
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 300,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _accountController,
                  decoration: InputDecoration(labelText: 'Account'),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                FlatButton(
                  child: (() => _captchaImage != null
                          ? _captchaImage
                          : Image.memory(base64Decode(
                              'iVBORw0KGgoAAAANSUhEUgAAAGQAAAAoCAQAAACicZfIAAAAO0lEQVR42u3PQREAAAgDINc/9Ezhx4MGpJ0XIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIicm8BF1dP2WLtVfwAAAAASUVORK5CYII=')))
                      .call(),
                  onPressed: refreshCaptcha,
                ),
                TextFormField(
                  controller: _captchaController,
                  decoration: InputDecoration(labelText: 'Code'),
                ),
                Builder(
                  builder: (context) => RaisedButton(
                    child: Text('Login'),
                    onPressed: () async {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Processing'),
                        duration: Duration(milliseconds: 500),
                      ));
                      var response = await postApi('account/login', {
                        'Account': _accountController.text,
                        'Password': _passwordController.text,
                        'Captcha': {
                          'HashId': _captchaHashId,
                          'Value': _captchaController.text,
                        }
                      });
                      if (response['Result'] != resultSuccess) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Failed'),
                          duration: Duration(milliseconds: 500),
                        ));
                        return;
                      }
                      jwt = response['Jwt'];
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserCenterPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void refreshCaptcha() async {
    var response = await getApi('public/captcha', {
      'language': language,
      'width': 200,
      'height': 80,
    });
    if (response['Result'] != resultSuccess) {
      return;
    }
    setState(() {
      _captchaHashId=response['HashId'];
      String imageBase64 = response['Picture'];
      imageBase64 = imageBase64.substring('data:image/png;base64,'.length);
      _captchaImage = Image.memory(base64Decode(imageBase64));
    });
  }
}
