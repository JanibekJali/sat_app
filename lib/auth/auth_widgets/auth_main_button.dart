import 'package:flutter/material.dart';

class AuthMainButtonWidget extends StatelessWidget {
  const AuthMainButtonWidget({
    super.key,
    required this.mainButtonLabel,
    required this.onPressed,
  });
  final String mainButtonLabel;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPressed,

          // if (_formKey.currentState!.validate()) {
          //   print('valid');
          // } else {
          //   print('not valid');
          // }

          child: Text(
            mainButtonLabel,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
