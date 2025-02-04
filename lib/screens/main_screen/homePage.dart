import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/cart_model/export.dart';
import 'package:highties_cannabis/screens/notification.dart';
import 'package:highties_cannabis/screens/profile_module/my_profile.dart';
import 'package:highties_cannabis/state/state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<StateController>();
  var userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = controller.authUser.value;
    print('userData');
    print(userData);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Hello, ${userData['customer_name'] ?? 'om'}',
                      style: TextStyle(
                          fontFamily: 'FontMain',
                          fontWeight: FontWeight.bold,
                          fontSize: 14 * textScale,
                          color: Colors.black)),
                  TextSpan(
                      text: '${userData?['customer_name'] ?? 'User'}',
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        color: const Color(0xff2A6443),
                        fontWeight: FontWeight.bold,
                        fontSize: 20 * textScale,
                      ))
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                Get.to(() => NotificationPage(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      'assets/images/Icon-bell.png',
                    ),
                  )),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Card(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Your Points',
                            style: TextStyle(
                              fontFamily: 'FontHead',
                              fontWeight: FontWeight.normal,
                              fontSize: 22 * textScale,
                            )),
                        const SizedBox(height: 15),
                        Text('Available Balance',
                            style: TextStyle(
                              fontFamily: 'FontMain',
                              color: Colors.grey,
                              fontSize: 17 * textScale,
                            )),
                        const SizedBox(height: 10),
                        Text(userData['springBigPointsBalance'].toString(),
                            style: TextStyle(
                              fontFamily: 'FontHead',
                              color: Colors.amber[200],
                              fontWeight: FontWeight.bold,
                              fontSize: 22 * textScale,
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset('assets/images/gold_coin.png'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'see details ',
                                style: TextStyle(
                                    fontFamily: 'FontHead',
                                    color: Colors.grey,
                                    // color: const Color(0xff2A6443),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        16 * textScale), // default text style
                                children: const [
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Colors.grey,
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Daily Deals',
                style: TextStyle(
                  fontFamily: 'FontHead',
                  fontWeight: FontWeight.bold,
                  fontSize: 16 * textScale,
                )),
            const SizedBox(
              height: 10,
            ),
            Card(
                child: Image.asset(
              'assets/images/1.png',
              fit: BoxFit.fitWidth,
            )),
            const SizedBox(
              height: 10,
            ),
            Card(
                child:
                    Image.asset('assets/images/1.png', fit: BoxFit.fitWidth)),
            const SizedBox(
              height: 10,
            ),
            Card(
                child: Image.asset(
              'assets/images/1.png',
              fit: BoxFit.fitWidth,
            )),
            const SizedBox(
              height: 10,
            ),
            Card(
                child:
                    Image.asset('assets/images/1.png', fit: BoxFit.fitWidth)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
