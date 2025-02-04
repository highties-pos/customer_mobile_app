import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/components/category_listing.dart';
import 'package:highties_cannabis/components/common_methos.dart';
import 'package:highties_cannabis/model/customer/get_all_store_model.dart';
import 'package:highties_cannabis/screens/location_module/map_page.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/store_details/product_item_wrapper.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/button.dart';
import 'package:get/get.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final salesController = Get.find<SalesController>();
  final stateController = Get.put(StateController());

  @override
  initState() {
    var warehouse = getSavedWareHouse();
    print("get saved warehouse");
    if (warehouse == null || warehouse['name'] == null) {
      print('warehouse is null');
      Future.delayed(Duration(seconds: 0), () {
        CommonMethod().showToast(
          context,
          title: "Warehouse Not Selected!",
          message: "Please select a warehouse.",
          type: 'info',
        );
        stateController.updateDashboardTabSelectedIndex(3);
      });
      return;
    }
    salesController.getWarehouseProducts();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.35;
    double screenHeightBtn = MediaQuery.of(context).size.height * 0.100;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Icon(
        //     Icons.arrow_back_ios_rounded,
        //     color: Color(0xff2A6443),
        //   ),
        // ),
        title: Text(
          getSavedWareHouse()?['name'] ?? '',
          style: TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xff2A6443),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Use a GridView.builder to create a grid with two items in each row
            Text('Categories:'),
            CategoryList(),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: salesController.warehouseProductsDataInfo.length,
                itemBuilder: (context, index) {
                  return ProductItemWrapper(
                    product: salesController.warehouseProductsDataInfo[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
