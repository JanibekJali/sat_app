import 'package:flutter/material.dart';

class GoogleFacebookLogInWidget extends StatelessWidget {
  const GoogleFacebookLogInWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.child,
  }) : super(key: key);
  final String label;
  final Function() onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: child,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
