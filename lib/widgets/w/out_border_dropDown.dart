import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDropdownWithoutBorder extends StatefulWidget {
  final String title;
  final String subTitle;
  final value;
  final Function onChanged;
  final List items;
  const CustomDropdownWithoutBorder(
      {super.key,
      required this.items,
      this.title = '',
      this.subTitle = '',
      required this.value,
      required this.onChanged});

  @override
  State<CustomDropdownWithoutBorder> createState() =>
      _CustomDropdownWithoutBorderState();
}

class _CustomDropdownWithoutBorderState
    extends State<CustomDropdownWithoutBorder> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15),
        //     border: Border.all(color: Colors.black)),
        padding: const EdgeInsets.only(left: 25, right: 15, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ButtonTheme(
                    child: DropdownButton<String>(
              isExpanded: true,
              underline: Container(
                height: 1,
                color: Colors.white,
              ),
              value: widget.value,
              iconSize: 15,
              icon: FaIcon(FontAwesomeIcons.circleChevronDown),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15 * textScale,
                fontFamily: 'FontMain',
              ),
              hint: Text(
                "Select",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16 * textScale,
                    fontFamily: 'FontMain',
                    color: Colors.grey),
              ),
              onChanged: (newValue) {
                widget.onChanged(newValue);
              },
              items: widget.items.map((item) {
                return DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Center(
                    child: Text(
                      item['name'].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19 * textScale,
                          fontFamily: 'FontMain',
                          color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
            )))
          ],
        ),
      )
    ]);
  }
}
