import 'package:flutter/material.dart';

class YellowButtonWidget extends StatelessWidget {
  const YellowButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.width,
  }) : super(key: key);
  final String label;
  final Function() onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * width,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
