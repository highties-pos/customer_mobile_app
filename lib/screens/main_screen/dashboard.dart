import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/location_module/animated_drawer_page.dart';
import 'package:highties_cannabis/screens/cart_module/cart.dart';
import 'package:highties_cannabis/screens/main_screen/homePage.dart';
import 'package:highties_cannabis/screens/order_module/products_page.dart';
import 'package:highties_cannabis/screens/profile_module/my_profile.dart';
import 'package:highties_cannabis/secure_storage/common.dart';
import 'package:highties_cannabis/state/state.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key, this.defaultIndex = 0});
  final int defaultIndex;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = Get.find<StateController>();

  final screen = [
    const HomePage(),
    const ProductsPage(),
    const CartPage(),
    const AnimatedDrawerPage(),
    const MyProfile(),
  ];

  void _onItemTapped(int index) {
    controller.updateDashboardTabSelectedIndex(index);
  }

  var userData;

  @override
  void initState() {
    super.initState();
    updateUser();
    userData = controller.authUser.value;
    controller.updateDashboardTabSelectedIndex(widget.defaultIndex);
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Want to exit from app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Not Now'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Exit App'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Obx(() => Scaffold(
            bottomNavigationBar: SizedBox(
              //height: 95,
              child: BottomNavigationBar(
                  fixedColor: const Color(0xff2A6443),
                  unselectedItemColor: Colors.grey.shade400,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const [
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.house),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.cubes),
                      label: 'More',
                    ),
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.cartShopping),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.locationDot),
                      label: 'Location',
                    ),
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.solidUser),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.dashboardTabSelectedIndex.value,
                  onTap: (value) {
                    controller.updateDashboardTabSelectedIndex(value);
                  },
                  elevation: 5),
            ),
            body: screen[controller.dashboardTabSelectedIndex.value],
          )),
    );
  }
}
