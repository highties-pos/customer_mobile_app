import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/components/category_listing.dart';
import 'package:highties_cannabis/constant/constnt.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/screens/cart_module/cart.dart';
import 'package:highties_cannabis/screens/cart_module/checkout.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/order_module/product_details.dart';
import 'package:highties_cannabis/screens/store_details/product_item_wrapper.dart';
import 'package:highties_cannabis/screens/store_details/ware_house.dart';
import 'package:highties_cannabis/state/salesController.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/button.dart';

class StoreDetail extends StatefulWidget {
  final storeData;
  const StoreDetail({super.key, required this.storeData});

  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  bool isFavorite = false;

  var userToken;
  var salesController = Get.find<SalesController>();
  var stateController = Get.find<StateController>();
  var _valueTCH = 0.0;
  var _valueCHC = 0.0;
  var filtersResponse;
  var filtersResData;
  var filtersResDataInfo;

  List sortsOptions = [];
  List terpenesOptions = [];
  List weightsOptions = [];

  Future getFiltersOptions() async {
    try {
      filtersResponse =
          await getReq("/items/filter-options", userToken.toString());

      if (filtersResponse.statusCode == 200) {
        filtersResData = jsonDecode(filtersResponse.body.toString());

        setState(() {
          filtersResDataInfo = filtersResData['result'];
          weightsOptions = filtersResDataInfo['weights'];
          terpenesOptions = filtersResDataInfo['terpenes'];
        });
        print("filtersResDataInfo:");
        print(filtersResDataInfo);
      } else {
        print(
            "Error fetching warehouses details. Status code: ${filtersResponse.statusCode}");
        print(filtersResponse.body.toString());
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = stateController.authToken.value;
    print('WareHouse Data is : ${widget.storeData}');
    getFiltersOptions();
    salesController.getWarehouseProducts();
  }

  List<String> selectedTerpenes = [];
  void _showFilterBottomSheet() {
    List<bool> isSelected = List.filled(weightsOptions.length, false);
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Sort & Filter',
                      style: TextStyle(
                        fontFamily: 'Fontmain',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(height: 20),
                  const Text(
                    'Terpenes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "FontMain",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: terpenesOptions
                              .map(
                                (terpene) => FilterChip(
                                  labelPadding: EdgeInsets.zero,
                                  label: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 6.0,
                                    ),
                                    child: Text(
                                      terpene,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  selected: selectedTerpenes.contains(terpene),
                                  onSelected: (isSelected) {
                                    setState(() {
                                      if (isSelected) {
                                        selectedTerpenes.add(terpene);
                                      } else {
                                        selectedTerpenes.remove(terpene);
                                      }
                                    });
                                    print(selectedTerpenes);
                                  },
                                  backgroundColor:
                                      selectedTerpenes.contains(terpene)
                                          ? const Color(0xff2A6443)
                                          : Colors.white,
                                  selectedColor: const Color(0xff2A6443),
                                  labelStyle: TextStyle(
                                    fontFamily: 'FontMain',
                                    color: selectedTerpenes.contains(terpene)
                                        ? Colors.white
                                        : const Color(0xff2A6443),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: const BorderSide(
                                      color: Color(0xff2A6443),
                                      width: 1.0,
                                    ),
                                  ),
                                  showCheckmark: false,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, state) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TCH",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "FontMain",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              _valueTCH.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: "FontMain",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 330,
                              child: CupertinoSlider(
                                value: _valueTCH,
                                min: 0.0,
                                max: 50.0,
                                onChanged: (val) {
                                  state(() {
                                    _valueTCH = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, state) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "CHC",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "FontMain",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              _valueCHC.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: "FontMain",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 330,
                              child: CupertinoSlider(
                                value: _valueCHC,
                                min: 0.0,
                                max: 50.0,
                                onChanged: (val) {
                                  state(() {
                                    _valueCHC = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Weights",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "FontMain",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 70,
                    //  runSpacing: ,
                    children: List.generate(weightsOptions.length, (index) {
                      final weight = weightsOptions[index];
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: isSelected[index],
                            onChanged: (bool? value) {
                              setState(() {
                                isSelected[index] = value!;
                                print('Selected Weights: $isSelected');
                              });
                            },
                          ),
                          Text("${weight + ' g'}",
                              style: const TextStyle(
                                  fontFamily: 'FontMain',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2A6443))),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Buttons(
                          onPressed: () {},
                          title: 'Reset',
                          height: 50,
                          width: double.infinity,
                          colors: const Color(0xffC8EDD9),
                          textColors: const Color(0xff027335),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Buttons(
                            onPressed: () {},
                            title: 'Save',
                            height: 50,
                            width: double.infinity,
                            colors: const Color(0xff2A6443),
                            textColors: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: Text('Redirecting...'));
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(0xff2A6443),
            ),
          ),
          title: Text(
            widget.storeData['name'],
            style: const TextStyle(
              fontFamily: 'FontMain',
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color(0xff2A6443),
            ),
          ),
          actions: [
            InkWell(
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: FaIcon(
                  FontAwesomeIcons.circleInfo,
                  color: Color(0xff2A6443),
                ),
              ),
              onTap: () {
                Get.to(() => WareHouseDetails(warehouseData: widget.storeData),
                    transition: Transition.rightToLeft);
              },
            ),
            InkWell(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset("assets/images/filter.png")),
              onTap: () {
                _showFilterBottomSheet();
              },
            )
          ]),
      bottomNavigationBar: Obx(() {
        final activeCartData = salesController.activeCartData.value.data;
        if (activeCartData != null && activeCartData.items.isNotEmpty) {
          return BottomAppBar(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Subtotal:',
                        style: TextStyle(
                          fontFamily: 'FontMain',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "\$ ${(activeCartData.baseTotal ?? 0)}",
                        style: const TextStyle(
                          fontFamily: 'FontMain',
                          fontSize: 18,
                          color: Color(0xff2A6443),
                        ),
                      ),
                    ],
                  ),
                  Buttons(
                    onPressed: () {
                      Get.to(
                        () => const CartPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    title: 'Go to Cart',
                    height: 50,
                    width: 120,
                    textColors: Colors.white,
                    colors: const Color(0xff2A6443),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox
              .shrink(); // Return an empty SizedBox if no items in cart
        }
      }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const CategoryList(),
            const SizedBox(height: 15),
            const Text(
              'Popular Deals',
              style: TextStyle(
                fontFamily: 'FontMain',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xff2A6443),
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => salesController.loadingWarehouseProductsDataInfo.value
                  ? const Center(child: CircularProgressIndicator())
                  : salesController.warehouseProductsDataInfo == null ||
                          salesController.warehouseProductsDataInfo.length == 0
                      ? const Center(
                          child: Text(
                          'No products found!',
                          style: TextStyle(
                            fontFamily: 'FontMain',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount:
                              salesController.warehouseProductsDataInfo.length,
                          itemBuilder: (context, index) {
                            return ProductItemWrapper(
                              product: salesController
                                  .warehouseProductsDataInfo[index],
                            );
                          },
                        ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
