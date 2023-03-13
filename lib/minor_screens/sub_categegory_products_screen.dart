import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sat_app/widgets/product_model/product_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widgets/app_bar_widgets.dart/app_bar_back_button_widget.dart';
import '../widgets/app_bar_widgets.dart/app_bar_title_widget.dart';

class SubCategegoryProductsScreen extends StatefulWidget {
  SubCategegoryProductsScreen({
    Key? key,
    required this.subCategName,
    required this.mainCategName,
  }) : super(key: key);
  final String subCategName;
  final String mainCategName;

  @override
  State<SubCategegoryProductsScreen> createState() =>
      _SubCategegoryProductsScreenState();
}

class _SubCategegoryProductsScreenState
    extends State<SubCategegoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        /* filtering -> where filtering to type of mainCategory */
        .where('maincateg', isEqualTo: widget.mainCategName)
        .where('subcateg', isEqualTo: widget.subCategName)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: const AppBarBackButtonWidget(),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: AppBarTitleWidget(title: widget.subCategName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'This category \n\n has no items yet  !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Acme',
                  letterSpacing: 1.5,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return ProductModel(
                  products: snapshot.data!.docs[index],
                );
              },
              staggeredTileBuilder: (context) => StaggeredTile.fit(1),
            ),
          );
        },
      ),
    );
  }
}
