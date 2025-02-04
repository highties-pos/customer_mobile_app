import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:highties_cannabis/screens/main_screen/dashboard.dart';
import 'package:highties_cannabis/screens/order_module/complete.dart';
import 'package:highties_cannabis/screens/order_module/tab_active.dart';

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({Key? key}) : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;

  Map<String, bool> _checkboxState = {
    'checkbox1': false,
    'checkbox2': false,
    'checkbox3': false,
    'checkbox4': false,
  };

  void _showBottomSheetModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff2A6443),
                  ),
                ),
              ),
              const Divider(height: 40),
              const SizedBox(height: 20),
              const Text(
                'Order Type',
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Color(0xff2A6443),
                    value: _checkboxState['checkbox1'] ?? false,
                    onChanged: (value) {
                      setState(() {
                        _checkboxState['checkbox1'] = value ?? false;
                        print('Checkbox 1: $_checkboxState');
                      });
                    },
                  ),
                  const Text(
                    'In Delivery',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2A6443),
                    ),
                  ),
                  Checkbox(
                    activeColor: Color(0xff2A6443),
                    value: _checkboxState['checkbox2'] ?? false,
                    onChanged: (value) {
                      setState(() {
                        _checkboxState['checkbox2'] = value ?? false;
                        print('Checkbox 2: $_checkboxState');
                      });
                    },
                  ),
                  const Text(
                    'Completed',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2A6443),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Color(0xff2A6443),
                    value: _checkboxState['checkbox3'] ?? false,
                    onChanged: (value) {
                      setState(() {
                        _checkboxState['checkbox3'] = value ?? false;
                        print('Checkbox 3: $_checkboxState');
                      });
                    },
                  ),
                  const Text(
                    'Store Pickup',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2A6443),
                    ),
                  ),
                  Checkbox(
                    activeColor: Color(0xff2A6443),
                    value: _checkboxState['checkbox4'] ?? false,
                    onChanged: (value) {
                      setState(() {
                        _checkboxState['checkbox4'] = value ?? false;
                        print('Checkbox 4: $_checkboxState');
                      });
                    },
                  ),
                  const Text(
                    'Failed',
                    style: TextStyle(
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2A6443),
                    ),
                  ),
                ],
              ),
              const Divider(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(150, 50)), // Adjust the size as needed
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green[100]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        color: Color(0xff2A6443),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Fontmain',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      minimumSize: const Size(150, 45),
                      maximumSize: const Size(150, 50),
                      backgroundColor: const Color(0xff2A6443),
                    ),
                    onPressed: () {
                      // Handle password update
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FontMain'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xff2A6443),
          ),
        ),
        leading: InkWell(
          onTap: () {
            //Get.off(DashboardPage());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashboardPage()));
          },
          child: const Icon(
            Icons.house,
            color: Color(0xff2A6443),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Color(0xff2A6443),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showBottomSheetModal(context);
            },
            child: Image.asset('assets/images/filter.png'),
          ),
          const SizedBox(width: 15),
        ],
        bottom: TabBar(
          labelStyle: const TextStyle(
            fontFamily: 'FontMain',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xff2A6443),
          ),
          controller: _tabController,
          indicatorColor: const Color(0xff2A6443),
          tabs: const [
            Tab(
              text: 'Active',
            ),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ActiveTab(), CompleteTab()],
      ),
    );
  }
}
