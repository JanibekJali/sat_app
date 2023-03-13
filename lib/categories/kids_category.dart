import 'package:flutter/material.dart';
import 'package:sat_app/utilities/categ_list.dart';
import 'package:sat_app/widgets/category_widgets/category_header_label_widget.dart';
import 'package:sat_app/widgets/category_widgets/slider_widget.dart';
import 'package:sat_app/widgets/category_widgets/sub_category_model_widget.dart';

class KidsCategory extends StatelessWidget {
  const KidsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryHeaderLabel(headerLabel: 'Kids'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.67,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(kids.length - 1, (index) {
                        return SubCategoryModel(
                          mainCategName: 'kids',
                          subCategName: kids[index + 1],
                          assetName: 'images/kids/kids$index.jpg',
                          subCategLabel: kids[index + 1],
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
              bottom: 0,
              right: 0,
              child: SliderBar(
                mainCategName: 'kids',
              ))
        ],
      ),
    );
  }
}
