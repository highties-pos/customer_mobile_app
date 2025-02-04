import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highties_cannabis/widgets/button.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List weedVarieties = [
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Purple Haze',
      'manufacturer': 'Green Gardens',
      'price': 45.99,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Sour Diesel',
      'manufacturer': 'Sunrise Farms',
      'price': 37.79,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Blue Dream',
      'manufacturer': 'High Harvest',
      'price': 55.99,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Purple Haze',
      'manufacturer': 'Green Gardens',
      'price': 45.99,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Sour Diesel',
      'manufacturer': 'Sunrise Farms',
      'price': 37.79,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Blue Dream',
      'manufacturer': 'High Harvest',
      'price': 55.99,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Purple Haze',
      'manufacturer': 'Green Gardens',
      'price': 45.99,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Sour Diesel',
      'manufacturer': 'Sunrise Farms',
      'price': 37.79,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
    {
      'imagePath': 'assets/images/pro.avif',
      'name': 'Blue Dream',
      'manufacturer': 'High Harvest',
      'price': 55.99,
      'weightInGrams': '3.5g',
      'grade': 'Color Cannabis',
      'type': 'Sativa',
      'volume': 'THC 14% - 20% | CBD 1%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.35;
    double screenHeightBtn = MediaQuery.of(context).size.height * 0.100;
    final textScale = MediaQuery.of(context).textScaleFactor;

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
          'Favourites',
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
            const SizedBox(height: 10),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(children: [
            //     InkWell(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: const Icon(
            //         Icons.arrow_back_ios_rounded,
            //         color: Color(0xff2A6443),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     const Text(
            //       'Favourites',
            //       style: TextStyle(
            //         fontFamily: 'FontMain',
            //         fontWeight: FontWeight.bold,
            //         fontSize: 25,
            //         color: Color(0xff2A6443),
            //       ),
            //     ),
            //   ]),
            // ),
            const SizedBox(
              height: 10,
            ),
            // Use a GridView.builder to create a grid with two items in each row
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: weedVarieties.length,
              itemBuilder: (context, index) {
                return _buildProductItem(weedVarieties[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              product['imagePath'],
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'by ${product['manufacturer']}',
                  style: const TextStyle(
                    fontFamily: 'FontMain',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product['price']}',
                      style: const TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xff2A6443),
                      ),
                    ),
                    Text(
                      '\$${product['weightInGrams']}',
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
                      '\$${product['grade']}',
                      style: const TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${product['type']}',
                      style: const TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product['volume'],
                  style: const TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Buttons(
              onPressed: () {},
              title: 'Add To Cart',
              height: 40,
              width: double.infinity,
              colors: Colors.green,
              textColors: Color(0xff2A6443),
            ),
          )
        ],
      ),
    );
  }
}
