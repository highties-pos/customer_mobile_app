import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highties_cannabis/http/api_request.dart';
import 'package:highties_cannabis/widgets/dropDwn.dart';
import 'package:highties_cannabis/widgets/w/out_border_dropDown.dart';

import '../../constant/constnt.dart';

class ProductDetail extends StatefulWidget {
  final productData;
  const ProductDetail({required this.productData, super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<dynamic> grams = [
    {
      "id": '1',
      "name": '3.5',
    },
    {
      "id": '2',
      "name": '2.5',
    },
    {
      "id": '3',
      "name": '1.5',
    },
  ];
  var selectedGrams;

  var proDetailResponse;
  var proDetailData;
  var proDetailDataInfo;

  Future getProductDetails() async {
    try {
      proDetailResponse = await getReq(
          '/items/mobile-app?item_code=${widget.productData['item_code']}');

      if (proDetailResponse.statusCode == 200) {
        proDetailData = jsonDecode(proDetailResponse.body.toString());

        setState(() {
          proDetailDataInfo = proDetailData['data'];
        });
        print("proDetailDataInfo:");
        print(proDetailDataInfo['item_name']);
      } else {
        print("error");
        print(proDetailResponse.body.toString());
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  bool isSelected = false;
  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  bool isFav = false;
  void _toggleFav() {
    setState(() {
      isFav = !isFav;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff51b390),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff2A6443),
          ),
        ),
      ),
      body: proDetailDataInfo == null || proDetailDataInfo == ''
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          height: 500,
                          color: const Color(0xff51b390),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  proDetailDataInfo['brand'],
                                  style: const TextStyle(
                                    fontFamily: 'FontMain',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  proDetailDataInfo['name'],
                                  style: const TextStyle(
                                    fontFamily: 'FontMain',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 30),
                                        const Text(
                                          'PRICE',
                                          style: TextStyle(
                                            fontFamily: 'FontMain',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '\$${proDetailDataInfo['selling_price']}',
                                          style: const TextStyle(
                                            fontFamily: 'FontMain',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'THC',
                                          style: TextStyle(
                                            fontFamily: 'FontMain',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${proDetailDataInfo['thc_min'] ?? '0.0'}% - ${proDetailDataInfo['thc_max'] ?? '0.0'}%',
                                          style: const TextStyle(
                                            fontFamily: 'FontMain',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          'CBD',
                                          style: TextStyle(
                                            fontFamily: 'FontMain',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${proDetailDataInfo['cbd_min'] ?? '0.0'}% - ${proDetailDataInfo['cbd_max'] ?? '0.0'}%',
                                          style: const TextStyle(
                                            fontFamily: 'FontMain',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 20, 0),
                                          child: Container(
                                            width: 160,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .grey, // Set the background color here
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Center(
                                                child: Image.network(
                                                  proDetailDataInfo['image'],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .grey, // Set the background color here
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Center(
                                                  child: Image.network(
                                                    proDetailDataInfo['image'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Container(
                                              width: 60,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .grey, // Set the background color here
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Center(
                                                  child: Image.network(
                                                    proDetailDataInfo[
                                                        'hero_shot_uri'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Container(
                                              width: 60,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .grey, // Set the background color here
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Center(
                                                  child: Image.network(
                                                    proDetailDataInfo['image'],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 20,
                          right: 0,
                          child: Row(
                            children: [
                              Card(
                                color: const Color(0xff2a6443),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const FaIcon(
                                        FontAwesomeIcons.cartShopping,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: _toggleFav,
                                      icon: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFav
                                              ? const Color(0xffe6bb82)
                                              : const Color(0xffD9D9D9))),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Container(
                          // color: Colors.grey,
                          //child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'TYPE',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                  const SizedBox(height: 17),
                                  Text(
                                    proDetailDataInfo['strain'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'GRAMS',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'FontMain',
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: 100,
                                    child: CustomDropdownWithoutBorder(
                                        items: grams,
                                        value: selectedGrams,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedGrams = newValue;
                                            print(" Grams :$selectedGrams");
                                          });
                                        }),
                                  ),
                                ],
                              )
                            ],
                          ),
                          //  ),

                          const SizedBox(height: 15),
                          const Text(
                            'About It',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              // fontSize: 15,

                              fontFamily: 'FontMain',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            proDetailDataInfo['short_description'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              // fontSize: 15,
                              fontFamily: 'FontMain',
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'EFFECTS',
                            style: TextStyle(
                              color: Color(0xff002140),
                              fontWeight: FontWeight.bold,
                              // fontSize: 15,

                              fontFamily: 'FontMain',
                            ),
                          ),
                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SelectableChip(
                                isSelected: isSelected,
                                // onTap: _toggleSelection,
                                avatar: Image.asset(
                                  'assets/images/relax.png',
                                  height: 20,
                                  width: 20,
                                  color: !isSelected ? null : Colors.white,
                                ),
                                // color:
                                //     isSelected ? Colors.grey : Colors.black,
                                //),
                                label: Text(
                                  'Calm',
                                  style: TextStyle(
                                    fontFamily: 'fontMain',
                                    fontWeight: FontWeight.bold,
                                    color: !isSelected
                                        ? Color(0xff002140)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              SelectableChip(
                                isSelected: isSelected,
                                // onTap: _toggleSelection,
                                avatar: Image.asset(
                                  'assets/images/emoji-happy.png',

                                  //ph_coffee-fill
                                  height: 20,
                                  width: 20,
                                  color: !isSelected
                                      ? Color(0xff002140)
                                      : Colors.white,
                                ),
                                label: Text(
                                  'Happy',
                                  style: TextStyle(
                                    fontFamily: 'fontMain',
                                    fontWeight: FontWeight.bold,
                                    color: !isSelected
                                        ? Color(0xff002140)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              SelectableChip(
                                isSelected: isSelected,
                                // onTap: _toggleSelection,
                                avatar: Image.asset(
                                  'assets/images/ph_coffee-fill.png',
                                  height: 20,
                                  width: 20,
                                  color: !isSelected
                                      ? Color(0xff002140)
                                      : Colors.white,
                                ),
                                label: Text(
                                  'Relaxed',
                                  style: TextStyle(
                                    fontFamily: 'fontMain',
                                    fontWeight: FontWeight.bold,
                                    color: !isSelected
                                        ? Color(0xff002140)
                                        : Colors.white,
                                  ),
                                ),
                              ),

                              // SelectableChip(
                              //   isSelected: isSelected,
                              //  // onTap: _toggleSelection,
                              //   avatar: const FaIcon(
                              //     FontAwesomeIcons.faceGrinStars,
                              //     color: Colors.grey,
                              //   ),
                              //   label: const Text(
                              //     'Energetic',
                              //     style: TextStyle(fontFamily: 'fontMain'),
                              //   ),
                              // ),
                            ],
                          ),

                          const SizedBox(height: 15),
                          const Text(
                            'DESCRIPTION',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              // fontSize: 15,

                              fontFamily: 'FontMain',
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            proDetailDataInfo['description'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              // fontSize: 15,
                              fontFamily: 'FontMain',
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SelectableChip extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget avatar;
  final Widget label;
  final Color? selectedColor;

  const SelectableChip({
    Key? key,
    required this.isSelected,
    this.onTap,
    required this.avatar,
    required this.label,
    this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        avatar: avatar,
        label: label,
        backgroundColor:
            isSelected ? const Color(0xff2a6443) : Color(0xffD9D9D9),
        side: !isSelected
            ? BorderSide(color: Color(0xffD9D9D9))
            : BorderSide(
                color: Color(0xffD9D9D9)), // Remove border if not selected
      ),
    );
  }
}
