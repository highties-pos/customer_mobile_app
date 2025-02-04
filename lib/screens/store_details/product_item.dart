import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/alert/toast.dart';
import 'package:highties_cannabis/components/common_methos.dart';
import 'package:highties_cannabis/screens/order_module/product_details.dart';
import 'package:highties_cannabis/widgets/button.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, this.product, this.handleAddToCart});
  final product;
  final handleAddToCart;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffE8EFF3)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(
                  () => ProductDetail(productData: widget.product),
                transition: Transition.rightToLeft,
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.network(
                      widget.product['image'],
                      height: 130,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? const Color(0xffe6bb82)
                          : const Color(0xff7D8FAB)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                Get.to(
                  // StoreDetail(storeData: warehouseDataInfo[index]),

                    () =>  ProductDetail(productData: widget.product),

                  transition: Transition.rightToLeft,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      CommonMethod().sliceText(widget.product['name'], 35),
                      style: const TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        //fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product['selling_price'] ?? 0}',
                        style: const TextStyle(
                            fontFamily: 'FontMain',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xffC29C1D)),
                      ),
                      Text(
                        '${widget.product['equivalent_to'] ?? 0} Grams',
                        style: const TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                      CommonMethod().sliceText(widget.product['brand'] ??
                          '', 8),
                        style: const TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.normal,
                          //fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${CommonMethod().sliceText(widget.product['strain'] ?? '', 8)}',
                        style: const TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   'Best Before : ${product['end_of_life']}',
                  //   style: const TextStyle(
                  //     fontFamily: 'FontMain',
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          const Spacer(), // Pushes the button to the bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Buttons(
              onPressed: () {
                widget.handleAddToCart(
                    onlyUpdateBatchNumber: false, batchNo: '',
                );
                showToast('Added to cart Successfully', true);
              },
              title: 'Add To Cart',
              height: 45,
              width: double.infinity,
              colors: const Color(0xffC8EDD9),
              textColors: const Color(0xff027335),
            ),
          )
        ],
      ),
    );
  }
}
