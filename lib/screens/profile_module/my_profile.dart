import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:highties_cannabis/screens/cart_module/payment_page.dart';
import 'package:highties_cannabis/screens/notification.dart';
import 'package:highties_cannabis/screens/order_module/orders_details.dart';
import 'package:highties_cannabis/screens/profile_module/edit_profile.dart';
import 'package:highties_cannabis/screens/profile_module/favorites.dart';
import 'package:highties_cannabis/screens/profile_module/security.dart';
import 'package:highties_cannabis/screens/sign_in.dart/sign_in.dart';
import 'package:highties_cannabis/state/state.dart';
import 'package:highties_cannabis/widgets/drawer_list.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final controller = Get.find<StateController>();
  var userData;

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userData = controller.authUser.value;
    });
    print('userData');
    print(userData);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthBtn = MediaQuery.of(context).size.width * 0.60;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile',
                    style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 25 * textScale,
                        color: const Color(0xff2A6443))),
                Card(
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => NotificationPage(),
                          transition: Transition.rightToLeft);
                    },
                    icon: const FaIcon(FontAwesomeIcons.solidBell,
                        color: const Color(0xff2A6443)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: image != null
                              ? Image.file(image!)
                              : Image.network(
                                  'https://xsgames.co/randomusers/avatar.php?g=male'),
                        ),
                      ),
                      Positioned(
                        right: -3,
                        bottom: 0,
                        child: Card(
                            color: const Color(0xff0D986A),
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isDismissible: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => pickMedia(),
                                  );
                                },
                                icon: const FaIcon(FontAwesomeIcons.pen,
                                    size: 18, color: Colors.white))),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => Center(
                child: Text(
                    "${controller.authUser.value?['customer_name'] ?? ''}",
                    style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 25 * textScale,
                        color: const Color(0xff0D986A))),
              ),
            ),
            Obx(
              () => Center(
                child: Text("${controller.authUser.value?['mobile_no'] ?? ''}",
                    style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 20 * textScale,
                        color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () => Get.to(
                const EditProfile(),
                transition: Transition.rightToLeft,
              ),
              leading: const FaIcon(
                FontAwesomeIcons.solidUser,
                color: Color(0xff0D986A),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 17 * textScale,
                  ),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                color: const Color(0xff0D986A),
              ),
            ),
            ListTile(
              onTap: () => Get.to(
                const OrdersDetails(),
                transition: Transition.rightToLeft,
              ),
              leading: const FaIcon(
                FontAwesomeIcons.newspaper,
                color: Color(0xff0D986A),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Orders",
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 17 * textScale,
                  ),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                color: const Color(0xff0D986A),
              ),
            ),
            ListTile(
              onTap: () => Get.to(
                const FavouritesPage(),
                transition: Transition.rightToLeft,
              ),
              leading: const FaIcon(
                FontAwesomeIcons.solidStar,
                color: Color(0xff0D986A),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Favourites",
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 17 * textScale,
                  ),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                color: const Color(0xff0D986A),
              ),
            ),
            ListTile(
              onTap: () => Get.to(
                const PaymentPage(),
                transition: Transition.rightToLeft,
              ),
              leading: const FaIcon(
                FontAwesomeIcons.creditCard,
                color: Color(0xff0D986A),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Payment",
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 17 * textScale,
                  ),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                color: const Color(0xff0D986A),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(
                  () => const SecurityPage(),
                  transition: Transition.rightToLeft,
                );
              },
              leading: const FaIcon(
                FontAwesomeIcons.userShield,
                color: Color(0xff0D986A),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  "Security",
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 17 * textScale,
                  ),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                color: const Color(0xff0D986A),
              ),
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.lock,
                color: Color(0xff0D986A),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 17 * textScale,
                  ),
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.angleRight,
                color: const Color(0xff0D986A),
              ),
            ),
            ListTile(
              onTap: () {
                _showLogoutModal(context);
              },
              leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket,
                  color: Colors.red),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("Sign Out",
                    style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.bold,
                        fontSize: 17 * textScale,
                        color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Ensures modal remains visible above the keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Prevent closing modal on tap
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontFamily: FontMain,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const Divider(height: 40),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Are you sure you want to sign out?',
                      style: TextStyle(
                        fontFamily: FontMain,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              const Size(150, 50)), // Adjust the size as needed
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[100]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Close modal
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xff0D986A),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Fontmain',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          minimumSize: const Size(150, 45),
                          maximumSize: const Size(150, 50),
                          backgroundColor: const Color(0xff2A6443),
                        ),
                        onPressed: () async {
                          await controller.unsetAuth();
                          Get.offAll(() => SignInPage());
                        },
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontMain),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pickMedia() => SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => pickImage(ImageSource.gallery),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 50,
                  ),
                  Text(
                    'Pick Gallery',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () => pickImage(ImageSource.camera),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 50,
                  ),
                  Text(
                    'Pick Camera',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
