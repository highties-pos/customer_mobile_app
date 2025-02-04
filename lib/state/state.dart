import 'package:get/get.dart';
import 'package:highties_cannabis/secure_storage/secure_storage.dart';

import 'dart:developer';
import 'dart:convert';

class StateController extends GetxController {
  // handle app state related stuff such as auth state...

  final authToken = ''.obs;
  final authUser = {}.obs;
  final dashboardTabSelectedIndex  = 0.obs;

  updateDashboardTabSelectedIndex(idx) {
    dashboardTabSelectedIndex.value = idx;
  }

  initAuth() async {
    final authTokenVal = await getAuthToken();
    final authUserVal = await getAuthUser();

    authToken.value = authTokenVal;
    authUser.value = authUserVal;
  }

  setAuthToken(data) async {
    authToken.value = data;
    await saveAuthToken(data);
  }

  setAuthUser(data) async {
    authUser.value = data;
    await saveAuthUser(data);
  }

  unsetAuth() async {
    print('unset auth called');
    authToken.value = '';
    authUser.value = {};
    // await clearStorage();

    await deleteAuthUser();
    await deleteAuthToken();
  }
}
