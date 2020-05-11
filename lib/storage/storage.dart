import 'dart:convert';
import 'dart:io';

File _windowsStorage = () {
  if (Platform.isWindows) {
    var windowsStorage = File(Directory.current.path + '\\config');
    windowsStorage.createSync();
    return windowsStorage;
  }
  return null;
}.call();

dynamic _windowsStorageGet(String key) {
  var windowsStorage = _windowsStorage.readAsStringSync();
  if (windowsStorage.isEmpty) {
    windowsStorage = '{}';
    _windowsStorage.writeAsStringSync(windowsStorage);
  }
  return jsonDecode(_windowsStorage.readAsStringSync())[key];
}

void _windowsStorageSet(String key, dynamic value) {
  var windowsStorageJson = jsonDecode(_windowsStorage.readAsStringSync());
  windowsStorageJson[key] = value;
  _windowsStorage.writeAsStringSync(jsonEncode(windowsStorageJson));
}

String get jwt {
  if (Platform.isWindows) {
    return _windowsStorageGet('Jwt');
  }
  throw UnsupportedError;
}

set jwt(String jwtSet) {
  if (Platform.isWindows) {
    _windowsStorageSet('Jwt', jwtSet);
    return;
  }
  throw UnsupportedError;
}
