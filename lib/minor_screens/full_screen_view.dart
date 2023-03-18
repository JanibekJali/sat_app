import 'package:flutter/material.dart';
import 'package:sat_app/widgets/app_bar_widgets.dart/app_bar_back_button_widget.dart';

class FullScreenView extends StatefulWidget {
  const FullScreenView({
    Key? key,
    required this.imagesList,
  }) : super(key: key);

  final List<dynamic> imagesList;

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppBarBackButtonWidget(),
      ),
      body: Column(
        children: [
          Text(
            '1/5',
            style: TextStyle(fontSize: 24, letterSpacing: 8),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView(
              children: List.generate(widget.imagesList.length, (index) {
                return InteractiveViewer(
                    transformationController: TransformationController(),
                    child: Image.network(widget.imagesList[index].toString()));
              }),
            ),
          ),
        ],
      ),
    );
  }
}
