import 'package:flutter/material.dart';
import 'package:highties_cannabis/widgets/drawer_list.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Drawer(
      child: ListView(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DrawerHeader(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.zero,
                child:
                    Image.asset("assets/images/logo.png", fit: BoxFit.contain)),
          ),
          const SizedBox(
            height: 10,
          ),
          ExpansionTile(
            iconColor: const Color(0xff832B29),
            leading: const Icon(
              Icons.account_box,
              color: Color(0xff832B29),
              size: 30,
            ),
            title: Text(
              "My Profile",
              style: TextStyle(
                color: Color(0xff832B29),
                fontFamily: 'FontMain',
                fontWeight: FontWeight.bold,
                fontSize: 16 * textScale,
              ),
            ),
            children: [
              // MiniCustomListTile(Icons.account_circle, "Employee Profile", () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const EmployeeProfile()));
              // }, Icons.arrow_forward_ios_rounded),
              // MiniCustomListTile(Icons.info, "Employee Details", () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const EmployeeDetails()));
              // }, Icons.arrow_forward_ios_rounded),
            ],
          ),
          // CustomListTile(Icons.calendar_month, "Attendance", () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => const OverTimePage()));
          // }, Icons.arrow_forward_ios_rounded),
          CustomListTile(
            Icons.radio_button_checked_rounded,
            "Check In and Out",
            () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const CheckInAndOutPage()));
            },
          ),
          CustomListTile(
            Icons.logout,
            "LogOut",
            () {},
          ),
        ],
      ),
    );
  }
}
