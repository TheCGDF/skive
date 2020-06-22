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

class Account {
  String url;
  String jwt;
  String remark;
  String node;
}

List<Account> accounts = _storageGet("Accounts") ?? [];

dynamic _storageGet(String key) {
  if (Platform.isWindows) {
    var windowsStorage = _windowsStorage.readAsStringSync();
    if (windowsStorage.isEmpty) {
      windowsStorage = '{}';
      _windowsStorage.writeAsStringSync(windowsStorage);
    }
    try {
      return jsonDecode(windowsStorage)[key];
    } catch (_) {
      _windowsStorage.writeAsStringSync('{}');
      return null;
    }
  }
  throw UnsupportedError;
}

void storageSet(String key, dynamic value) {
  if (Platform.isWindows) {
    var windowsStorageJson = jsonDecode(_windowsStorage.readAsStringSync());
    windowsStorageJson[key] = value;
    _windowsStorage.writeAsStringSync(jsonEncode(windowsStorageJson));
  }
  throw UnsupportedError;
}
