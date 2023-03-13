import 'package:flutter/material.dart';
import 'package:sat_app/minor_screens/sub_categegory_products_screen.dart';

class SubCategoryModel extends StatelessWidget {
  const SubCategoryModel({
    Key? key,
    required this.assetName,
    required this.mainCategName,
    required this.subCategLabel,
    required this.subCategName,
  }) : super(key: key);
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategegoryProductsScreen(
                // subCategName: men[index], mainCategName: 'men'),
                subCategName: subCategName,
                mainCategName: mainCategName),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            // color: Colors.blue,
            child: Image(
              // image: AssetImage('images/men/men$index.jpg'),
              image: AssetImage(assetName),
            ),
          ),
          // Text(men[index]),
          Text(subCategLabel),
        ],
      ),
    );
  }
}
