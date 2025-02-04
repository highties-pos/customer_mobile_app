import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

final dataStorages3 = GetStorage();

FlutterSecureStorage secureStorage = const FlutterSecureStorage();

Future<void> save(String key, String value) async {
  await dataStorages3.write(key, value);
}

Future<String> getValue(String key) async {
  return await dataStorages3.read(key) ?? "";
}

Future saveAuthToken(token) async {
  return await save('AUTH_TOKEN', token);
}

Future saveAuthUser(data) async {
  return await save('AUTH_USER', jsonEncode(data));
}

Future getAuthToken() async {
  return await getValue('AUTH_TOKEN');
}

Future getAuthUser() async {
  var user = await getValue('AUTH_USER');
  if (user.isNotEmpty) {
    return jsonDecode(user);
  } else {
    var userNew = {};
    await saveAuthUser(userNew);
    return userNew;
  }
}

clearStorage() {
  dataStorages3.erase();
}
Future deleteAuthUser() async {
  print('delete auth user running');

  dataStorages3.erase();
  // await secureStorage.delete(key: 'AUTH_USER');
}

Future deleteAuthToken() async {
  print('delete auth token running');

  dataStorages3.erase();
  // await secureStorage.delete(key: 'AUTH_TOKEN');
}
