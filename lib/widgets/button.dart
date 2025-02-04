import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String title;
  final Color colors;
  final Color textColors;

  const Buttons({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.height,
    required this.width,
    required this.colors,
    required this.textColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          minimumSize: Size(width, height),
          maximumSize: Size(width, height),
          backgroundColor: colors),
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'FontMain',
            color: textColors,
            fontSize: 16 * textScale,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
