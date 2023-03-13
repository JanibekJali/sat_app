import 'package:flutter/material.dart';
import 'package:sat_app/constants/text_style.dart';

class AppBarTitleWidget extends StatelessWidget {
  const AppBarTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: AppTextStyles.subCategStyle));
  }
}
