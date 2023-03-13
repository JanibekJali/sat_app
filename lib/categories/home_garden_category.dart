import 'package:flutter/material.dart';
import 'package:sat_app/utilities/categ_list.dart';
import 'package:sat_app/widgets/category_widgets/category_header_label_widget.dart';
import 'package:sat_app/widgets/category_widgets/slider_widget.dart';
import 'package:sat_app/widgets/category_widgets/sub_category_model_widget.dart';

class HomeGardenCategory extends StatelessWidget {
  const HomeGardenCategory({super.key});

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
                  const CategoryHeaderLabel(headerLabel: 'Home & Garden'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.67,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children:
                          List.generate(homeandgarden.length - 1, (index) {
                        return SubCategoryModel(
                          mainCategName: 'homeandgarden',
                          subCategName: homeandgarden[index + 1],
                          assetName: 'images/homegarden/home$index.jpg',
                          subCategLabel: homeandgarden[index + 1],
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
                mainCategName: 'homeandgarden',
              ))
        ],
      ),
    );
  }
}
