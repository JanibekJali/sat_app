import 'package:flutter/material.dart';
import 'package:sat_app/widgets/app_bar_widgets.dart/app_bar_back_button_widget.dart';
import 'package:sat_app/widgets/app_bar_widgets.dart/app_bar_title_widget.dart';

class MyStore extends StatelessWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitleWidget(title: 'My Store'),
        leading: AppBarBackButtonWidget(),
      ),
    );
  }
}
