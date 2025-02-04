import 'package:flutter/material.dart';
import 'package:highties_cannabis/screens/location_module/drawer_screen.dart';

import 'package:highties_cannabis/screens/location_module/map_page.dart';

class AnimatedDrawerPage extends StatefulWidget {
  const AnimatedDrawerPage({super.key});

  @override
  State<AnimatedDrawerPage> createState() => _AnimatedDrawerPageState();
}

class _AnimatedDrawerPageState extends State<AnimatedDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), MapPage()],
      ),
    );
  }
}
