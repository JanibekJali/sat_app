import 'package:flutter/material.dart';
import 'package:sat_app/widgets/app_bar_widgets.dart/app_bar_title_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitleWidget(title: 'Stores'),
      ),
    );
  }
}
