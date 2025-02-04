import 'package:highties_cannabis/constant/constnt.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 

// dio related http utils are required for multipart form upload.
// dio related http utils....

const storage = FlutterSecureStorage();
// with default Optionsdart pub add dio

// Set default configs
var options = BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 10000),
  receiveTimeout: const Duration(seconds: 120000),
);

Dio dioReq = Dio(options);
Future getAccessToken() async {
  await storage.read(key: 'AUTH_TOKEN');
}

Future fetchData(url, [authToken = ""]) async {
  dioReq.options.headers["authorization"] = "Bearer ${authToken}";
  var res = await dioReq.get(url);
  return res.data;
}

Future postData(url, data, [authToken = ""]) async {
  dioReq.options.headers["authorization"] = "Bearer ${authToken}";
  var res;
  try {
    print('patch req url: $baseUrl + $url');
    res = await dioReq.post(url, data: data);
    print('patch res');
    if (res != null) {
      print(res.data);
    } else {
      throw new Error();
    }
  } catch (err) {
    print(err);
    throw err;
  }
  return res.data;
}

Future patchDataFullResponse(url, data, [authToken = ""]) async {
  dioReq.options.headers["authorization"] = "Bearer ${authToken}";
  var res;
  try {
    print('patch req url: $baseUrl + $url');
    res = await dioReq.patch(url, data: data);
    print('patch res');
    if (res != null) {
      print(res.data);
    } else {
      throw new Error();
    }
  } catch (err) {
    print(err);
    throw err;
  }
  return res;
}

Future patchData(url, data, [authToken = ""]) async {
  dioReq.options.headers["authorization"] = "Bearer ${authToken}";
  var res;
  try {
    print('post req url: $baseUrl + $url');
    res = await dioReq.patch(url, data: data);
    print('post res');
    if (res != null) {
      print(res.data);
    } else {
      throw new Error();
    }
  } catch (err) {
    print(err);
    throw err;
  }
  return res.data;
}
