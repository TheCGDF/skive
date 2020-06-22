import 'dart:js' as js;

import 'package:flutter/foundation.dart';

String _jwt = (() => kIsWeb
    ? js.context.callMethod('getCookie', ['Jwt'])
    : throw UnsupportedError).call();

String get jwt => _jwt;

void setJwt(String jwtNew, bool save) {
  _jwt = jwtNew;
  if (!save) {
    return;
  }

  kIsWeb
      ? js.context.callMethod('setCookie', ['Jwt', jwtNew, 24 * 7])
      : throw UnsupportedError;
}
