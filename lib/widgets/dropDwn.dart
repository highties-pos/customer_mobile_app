import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final String subTitle;
  final value;
  final Function onChanged;
  final List items;
  const CustomDropdown(
      {super.key,
      required this.items,
      this.title = '',
      this.subTitle = '',
      required this.value,
      required this.onChanged});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black)),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ButtonTheme(
                    child: DropdownButton<String>(
              isExpanded: true,
              // underline: Container(
              //   height: 2,
              //   color: const Color(0xff832B29),
              // ),
              value: widget.value,
              iconSize: 30,
              icon: Icon(Icons.arrow_drop_down_outlined),
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
                  child: Text(
                    item['name'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15 * textScale,
                        fontFamily: 'FontMain',
                        color: Colors.black),
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
