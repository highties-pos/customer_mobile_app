import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  String text;
  IconData icon1;
  Function onTap;
  CustomListTile(this.icon1, this.text, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(
                  icon1,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 25.0, 10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontFamily: 'FontMain',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17 * textScale),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
