import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetPackage;
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/state/state.dart';

final authController = GetPackage.Get.find<StateController>();
final controller = GetPackage.Get.find<StateController>();

updateUser() async {
  final userRes = await getReq('/auth/me', controller.authToken.value);

  if (userRes.statusCode == 200) {
    await controller.setAuthUser(jsonDecode(userRes.body)['result']);
    return true;
  }
}

createFormMapData(images,
    [data = const {}, imageKeyNames = const ['image']]) async {
  // create a multipart form data including image
  // use for image uploads

  Map<String, dynamic> formMapData = {};
  var i = 0;

  if (images != null) {
    for (var imageKeyName in imageKeyNames) {
      if (images[i] != null && !images[i].isEmpty) {
        print('image $i : ' + images[i]);
      }
      formMapData[imageKeyName] = images[i] != null
          ? await MultipartFile.fromFile(images[i] ?? '')
          : null;
      i++;
    }
  }

  // append other provided data to form data.
  data.forEach((key, value) {
    formMapData[key] = value;
  });

  print('form map data is');
  // print(jsonEncode(formMapData));

  return FormData.fromMap(formMapData);
}
