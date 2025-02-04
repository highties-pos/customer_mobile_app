// To parse this JSON data, do
//
//     final getAllStoreDataModel = getAllStoreDataModelFromJson(jsonString);

import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'dart:developer';

/**
 * WAREHOUSE AND POS PROFILE SAVING
 */
final dataStorages2 = GetStorage();

dynamic decodeJsonSafely(String jsonString) {
  try {
    final jsonData = jsonDecode(jsonString);
    return jsonData;
  } catch (e) {
    // If an exception is thrown, return an empty object
    return {};
  }
}

/**
 * USER ADDING / REMOVING related
 */
void saveLoggedInUsers(data) {
  dataStorages2.write('logged_in_users', jsonEncode(data));
}

void addLoggedInUser(username) {
  var users = getLoggedInUsers();
  if (!users.contains(username)) {
    print('add logged in user called');
    users.add(username);
  }
  saveLoggedInUsers(users);
}

void removeLoggedInUser(username) {
  var users = getLoggedInUsers();
  users.remove(username);
  saveLoggedInUsers(users);
}

getLoggedInUsers() {
  var loggedInUsers = dataStorages2.read('logged_in_users');
  print(jsonEncode(loggedInUsers));
  return loggedInUsers != null ? jsonDecode(loggedInUsers) : [];
}

void clearLoggedInUsers(data) {
  dataStorages2.write('logged_in_users', jsonEncode([]));
}

/**
 * END OF USER ADDING / REMOVING
 */

/**
 * CART RELATED STORES
 */

void saveCartToMemory(data) {
  dataStorages2.write('cart', jsonEncode(data));
}

dynamic getCartFromMemory() {
  var originalData = dataStorages2.read('cart');
  var data = originalData != null ? decodeJsonSafely(originalData) : {};
  return data;
}

/**
 * WAREHOUSE RELATED MODELS
 */
void saveSelectedWareHouse(data) {
  dataStorages2.write('warehouse', jsonEncode(data));
}

getSavedWareHouseData() {
  // get all
  var originalData = dataStorages2.read('warehouse');
  print(
      'the original data of ware hosue is ALLL DATA WAREHOUSESS ${originalData}');
  var data = originalData != null ? decodeJsonSafely(originalData) : {};
  return data;
}

getSavedWareHouse() {
  // get for a user
  var originalData = dataStorages2.read('warehouse');
  return originalData != null ? jsonDecode(originalData) : {};
}

void saveSelectedWareHouseData(data) {
  print('save selected warehouse data --- ${jsonEncode(data)}');
  dataStorages2.write('warehouse', jsonEncode(data));
}

/**
 * POS PROFILE NAME MODELS
 */
void saveSelectedPOSProfileName(name) {
  // saves for specific user.
  var data = getSelectedPOSProfileNameData();
  var username = getUsername();
  data[username] = name;
  dataStorages2.write('pos_profile_name', jsonEncode(data));
  var getSel = getSelectedPOSProfileName();
  print('get sel $getSel');
}

void saveSelectedPOSProfileNameData(data) {
  // saves all
  dataStorages2.write('pos_profile_name', jsonEncode(data));
}

getSelectedPOSProfileNameData() {
  var originalData = dataStorages2.read('pos_profile_name');

  log('the pos profile naem is ${originalData}');
  dynamic data = originalData != null && originalData != ''
      ? decodeJsonSafely(originalData)
      : {};

  if (data.runtimeType == String || data.runtimeType == 'String') {
    data = {};
  }

  return data;
}

getSelectedPOSProfileName() {
  var data = getSelectedPOSProfileNameData();
  var username = getUsername();

  return data[username];
}

/**
 * END WAREHOUSE AND POS PROFILE SAVING
 */

/**
 * CART BATCH - ITEM CODE MAPPED RELATED MODELS
 */

getSavedBatchNumberData() {
  // get all
  var originalData = dataStorages2.read('batch_numbers');
  var data = originalData != null ? decodeJsonSafely(originalData) : {};
  return data;
}

void saveBatchNumberData(data) {
  dataStorages2.write('batch_numbers', jsonEncode(data));
}

void saveBatchNumber(itemCode, batchNumber) {
  print('save batch number $itemCode : $batchNumber');
  var batchNumberVal = getSavedBatchNumberData();
  var username = getUsername();

  var newData = batchNumberVal[username];
  if (newData == null) {
    newData = {};
  }

  newData[itemCode] = batchNumber;

  print('the new data is');
  print(jsonEncode(newData));
  batchNumberVal[username] = newData;

  saveBatchNumberData(batchNumberVal);
}

getSavedBatchNumber(itemCode) {
  // get for a user
  var batchNumberVal = getSavedBatchNumberData();
  var username = getUsername();
  return batchNumberVal != null && batchNumberVal[username] != null
      ? batchNumberVal[username][itemCode]
      : '';
}

// misc

String getUsername() {
  var username = dataStorages2.read("username");
  return username ?? '';
}

GetAllStoreDataModel getAllStoreDataModelFromJson(String str) =>
    GetAllStoreDataModel.fromJson(json.decode(str));

String getAllStoreDataModelToJson(GetAllStoreDataModel data) =>
    json.encode(data.toJson());

clearDataStorageKeysExceptEssential() {
  // preserve - selected warehouse, pos profile name, and logged in users
  var savedWareHouse = getSavedWareHouseData();
  var selectedPOSProfileName = getSelectedPOSProfileNameData();
  var users = getLoggedInUsers();
  //
  // print('BEFORE LOGGING out ---- ');
  // print('saved warehouse ${jsonEncode(savedWareHouse)}');
  // print('saved pos profile name ${jsonEncode(selectedPOSProfileName)}');

  // remove all keys
  dataStorages2.erase();

  // todo: renable again this.....
  //  except preserve these 2 keys
  saveLoggedInUsers(users);
  saveSelectedWareHouseData(savedWareHouse);
  saveSelectedPOSProfileNameData(selectedPOSProfileName);
}

class GetAllStoreDataModel {
  List<GetStoreData>? data;

  GetAllStoreDataModel({
    this.data,
  });

  factory GetAllStoreDataModel.fromJson(Map<String, dynamic> json) =>
      GetAllStoreDataModel(
        data: json["result"] == null
            ? []
            : List<GetStoreData>.from(
                json["result"]!.map((x) => GetStoreData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetStoreData {
  String? id;
  String? name;

  GetStoreData({
    this.id,
    this.name,
  });

  factory GetStoreData.fromJson(Map<String, dynamic> json) => GetStoreData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
