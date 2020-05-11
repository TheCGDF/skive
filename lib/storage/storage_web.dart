import 'dart:js' as js;

import 'package:flutter/foundation.dart';

String get jwt {
  if (kIsWeb) {
    return js.context.callMethod('getCookie', ['Jwt']);
  }
  return null;
}

set jwt(String jwtSet) {}
