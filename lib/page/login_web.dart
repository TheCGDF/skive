import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skive/page/home_web.dart';
import 'package:skive/page/page.dart';
import 'package:skive/page/register_web.dart';
import 'package:skive/page/user_center.dart';
import 'package:skive/storage/cookie_web.dart';
import 'package:skive/storage/jwt_web.dart';

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
        title: appBarTitle("LOGIN", this),
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
          width: 240,
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
                              'iVBORw0KGgoAAAANSUhEUgAAAMgAAABQCAQAAAD2ZPI7AAAAgElEQVR42u3RAQ0AAAgDIN8/9K3hHFQg7XBIhAhBiBCECEGIEIQIQQhChCBECEKEIEQIQhAiBCFCECIEIUIQghAhCBGCECEIEYIQhAhBiBCECEGIEIQgRAhChCBECEKEIAQhQhAiBCFCECIEIQgRghAhCBGCECEIQYgQhAhByB8LXMSfsfEKQl0AAAAASUVORK5CYII=')))
                      .call(),
                  onPressed: refreshCaptcha,
                ),
                TextFormField(
                  controller: _captchaController,
                  decoration: InputDecoration(labelText: 'Code'),
                ),
                CheckboxListTile(
                  title: Text('Auto login next time'),
                  value: saveJwt,
                  onChanged: (auto) => setState(() => saveJwt = auto),
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
                      setCurrentJwt(response['Jwt']);
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
      'width': 240,
      'height': 80,
    });
    if (response['Result'] != resultSuccess) {
      return;
    }
    setState(() {
      _captchaHashId = response['HashId'];
      String imageBase64 = response['Picture'];
      imageBase64 = imageBase64.substring('data:image/png;base64,'.length);
      _captchaImage = Image.memory(base64Decode(imageBase64));
    });
  }
}
