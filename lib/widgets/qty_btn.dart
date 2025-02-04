import 'package:flutter/material.dart';

class QuantityBtn extends StatefulWidget {
  const QuantityBtn(
      {super.key,
      this.qty = 1,
      required this.onIncrement,
      required this.onDecrement});
  final qty;
  final Function() onIncrement;
  final Function() onDecrement;

  @override
  State<QuantityBtn> createState() => _QuantityBtnState();
}

class _QuantityBtnState extends State<QuantityBtn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          child: IconButton(
            onPressed: () {
              widget.onDecrement();
            },
            icon: const Icon(
              Icons.remove,
              color: const Color(0xff002140),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '${widget.qty}',
            style: const TextStyle(
                color: Color(0xff2A6443),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Card(
          child: IconButton(
            onPressed: () {
              widget.onIncrement();
            },
            icon: const Icon(
              Icons.add,
              color: Color(0xff002140),
            ),
          ),
        ),
      ],
    );
  }
}
