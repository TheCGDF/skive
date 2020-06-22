import 'dart:io';

import 'package:skive/storage/storage_client.dart';

String _currentJwt;

String get currentJwt => _currentJwt;

void setCurrentJwt(String jwt) {
  _currentJwt = jwt;
  accounts[accounts.indexWhere((element) => element.jwt == jwt)].jwt = jwt;
  storageSet("Accounts", accounts);
}

void logoutJwt() {
  accounts.removeWhere((account) => account.jwt == currentJwt);
  storageSet("Accounts", accounts);
}
