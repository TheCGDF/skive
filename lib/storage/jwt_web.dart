import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:skive/storage/cookie_web.dart';

String _currentJwt = (() => kIsWeb
    ? js.context.callMethod('getCookie', ['Jwt'])
    : throw UnsupportedError).call();
String get currentJwt => _currentJwt;

void setCurrentJwt(String jwt) {
  _currentJwt = jwt;
  if (!saveJwt) {
    return;
  }
  kIsWeb
      ? js.context.callMethod('setCookie', ['Jwt', jwt, 24 * 7])
      : throw UnsupportedError;
}

void logoutJwt(){
  _currentJwt=null;
  saveJwt=false;
  kIsWeb
      ? js.context.callMethod('removeCookie', ['Jwt'])
      : throw UnsupportedError;
}