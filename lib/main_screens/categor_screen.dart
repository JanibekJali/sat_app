import 'package:flutter/material.dart';
import 'package:sat_app/categories/accessories_category.dart';
import 'package:sat_app/categories/bags_category.dart';
import 'package:sat_app/categories/beauty_category.dart';
import 'package:sat_app/categories/electronics_category.dart';
import 'package:sat_app/categories/home_garden_category.dart';
import 'package:sat_app/categories/kids_category.dart';
import 'package:sat_app/categories/men_categ.dart';
import 'package:sat_app/categories/shoes_category.dart';
import 'package:sat_app/categories/women_categories.dart';
import 'package:sat_app/widgets/fake_search_widget.dart';

List<ItemsData> items = [
  ItemsData(label: 'men'),
  ItemsData(label: 'women'),
  ItemsData(label: 'shoes'),
  ItemsData(label: 'bags'),
  ItemsData(label: 'electronics'),
  ItemsData(label: 'accessories'),
  ItemsData(label: 'home & garden'),
  ItemsData(label: 'kids'),
  ItemsData(label: 'beauty'),
];

class CategorScreen extends StatefulWidget {
  const CategorScreen({Key? key}) : super(key: key);

  @override
  _CategorScreenState createState() => _CategorScreenState();
}

class _CategorScreenState extends State<CategorScreen> {
  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const FakeSearchWidget(),
      ),
      body: Stack(children: [
        Positioned(bottom: 0, left: 0, child: sideNavigator(size)),
        Positioned(bottom: 0, right: 0, child: categView(size)),
      ]),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      // height: 800,
      height: size.height * 0.8,
      width: size.width * 0.2,
      // color: Colors.grey.shade300,
      child: ListView.builder(
          // itemCount: maincateg.length,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // _pageController.jumpToPage(index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(microseconds: 100),
                  curve: Curves.bounceInOut,
                );
                // for (var element in items) {
                //   element.isSelected = false;
                // }
                // setState(() {
                //   items[index].isSelected = true;
                // });
              },
              child: Container(
                  color: items[index].isSelected == true
                      ? Colors.white
                      : Colors.grey.shade300,
                  height: 100,
                  child: Center(child: Text(items[index].label))),
            );
          }),
    );
  }

  Widget categView(Size size) {
    return Container(
      // height: 800,
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: (value) {
            for (var element in items) {
              element.isSelected = false;
            }
            setState(() {
              items[value].isSelected = true;
            });
          },
          children: const [
            // Center(child: Text('men category')),
            // Center(child: Text('women category')),
            MenCategory(),
            WomenCategory(),
            ShoesCategory(),
            BagsCategory(),
            ElectronicsCategory(),
            AccessoriesCategory(),
            HomeGardenCategory(),
            KidsCategory(),
            BeautyCategory(),
          ]),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;
  ItemsData({required this.label, this.isSelected = false});
}
