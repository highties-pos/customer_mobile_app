import 'package:highties_cannabis/constant/constnt.dart';
import 'package:http/http.dart' as http;
 
import 'dart:convert';

Future postReq(url, [token = '', payload = const []]) async {
  var finalUrl = Uri.parse(baseUrl + url);
  print('final url is $finalUrl');
  var res = await http.post(
    finalUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer $token'
    },
    body: jsonEncode(payload),
  );
  return res;
}

Future patchReq(url, [token = '', payload = const []]) async {
  return await http.patch(Uri.parse(baseUrl + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(payload));
}

Future getReq(url, [token = ""]) async {
  return await http.get(
    Uri.parse(baseUrl + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer $token'
    },
  );
}
