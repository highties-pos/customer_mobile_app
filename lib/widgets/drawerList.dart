import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MiniCustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  IconData icon1;
  Function onTap;
  MiniCustomListTile(this.icon1, this.text, this.onTap, this.icon, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 15.0, 10.0),
                child: Icon(
                  icon1,
                  color: Color(0xff832B29),
                  size: 22,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    color: Color(0xff832B29),
                    fontFamily: 'FontMain',
                    fontWeight: FontWeight.bold,
                    fontSize: 15 * textScale),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 24.0, 5),
            child: Icon(
              icon,
              color: Colors.black,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
