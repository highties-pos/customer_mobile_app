import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/model/customer/get_all_store_model.dart';
import 'package:highties_cannabis/screens/store_details/store_detail.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/drawer_list.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final controller = Get.find<StateController>();

  var userToken;

  var warehouseResponse;
  var warehouseData;
  var warehouseDataInfo;

  Future getWareHouseList() async {
    try {
      warehouseResponse = await getReq('/warehouses', userToken.toString());

      if (warehouseResponse.statusCode == 200) {
        warehouseData = jsonDecode(warehouseResponse.body.toString());

        setState(() {
          warehouseDataInfo = warehouseData['result'];
        });
        print("warehouseDataInfo:");
        print(warehouseDataInfo);
      } else {
        print("error");
        print(warehouseResponse.body.toString());
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = controller.authToken.value;

    getWareHouseList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff0D986A),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, bottom: 70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomListTile(
                  FontAwesomeIcons.shop,
                  "Store List",
                  () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                warehouseDataInfo == null
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: warehouseDataInfo.length,
                        itemBuilder: (context, index) => SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomListTile(
                                FontAwesomeIcons.locationDot,
                                warehouseDataInfo[index]['name'],
                                () {
                                  saveSelectedWareHouse(
                                      warehouseDataInfo[index]);
                                  Get.to(
                                    () => StoreDetail(
                                        storeData: warehouseDataInfo[index]),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
