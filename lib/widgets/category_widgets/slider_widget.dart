import 'package:flutter/material.dart';
import 'package:sat_app/constants/text_style.dart';

class SliderBar extends StatelessWidget {
  const SliderBar({
    Key? key,
    required this.mainCategName,
  }) : super(key: key);
  final String mainCategName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RotatedBox(
              quarterTurns: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  mainCategName == 'beauty'
                      ? const Text('')
                      : const Text('<<', style: style),
                  Text(mainCategName.toUpperCase(), style: style),
                  mainCategName == 'men'
                      ? const Text('')
                      : const Text('>>', style: style),
                ],
              )),
        ),
      ),
    );
  }
}
