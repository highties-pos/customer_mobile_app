import 'package:highties_cannabis/constant/constnt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/state/salesController.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final salesController = Get.find<SalesController>();
  dynamic selectedCategoryId = 0;

  @override
  initState() {
    salesController.getWarehouseItemGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => salesController.itemGroupDataInfo == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
            //color: Color(0xff2A6443),
            height: 185,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: salesController.itemGroupDataInfo.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 13),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryId =
                            salesController.itemGroupDataInfo[index]['id'];
                      });
                      salesController.getWarehouseProducts(
                        categoryId: salesController.itemGroupDataInfo[index]
                            ['name'],
                      );
                    },
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 100,
                        width: 130,
                        color: selectedCategoryId ==
                                salesController.itemGroupDataInfo[index]['id']
                            ? Colors.lightBlueAccent.shade100
                            : null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                salesController.itemGroupDataInfo[index]
                                        ['image'] ??
                                    dummyImgUrl,
                                fit: BoxFit.cover,
                                height: 100,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              salesController.itemGroupDataInfo[index]['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontMain',
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2A6443),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
  }
}
