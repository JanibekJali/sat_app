import 'package:flutter/material.dart';
import 'package:sat_app/categories/accessories_category.dart';
import 'package:sat_app/categories/bags_category.dart';
import 'package:sat_app/categories/electronics_category.dart';
import 'package:sat_app/categories/shoes_category.dart';
import 'package:sat_app/categories/women_categories.dart';
import 'package:sat_app/galleries/accessories_gallery_screen.dart';
import 'package:sat_app/galleries/bags_gallery_screen.dart';
import 'package:sat_app/galleries/beauty_gallery_screen.dart';
import 'package:sat_app/galleries/electronics_gallery_screen.dart';
import 'package:sat_app/galleries/homegarden_gallery_screen.dart';
import 'package:sat_app/galleries/kids_gallery_screen.dart';
import 'package:sat_app/galleries/men_gallery_screen.dart';
import 'package:sat_app/galleries/shoes_gallery_screen.dart';
import 'package:sat_app/galleries/women_gallery_screen.dart';
import 'package:sat_app/widgets/fake_search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          // title: const CupertinoSearchTextField(),
          title: const FakeSearchWidget(),
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.yellow,
              indicatorWeight: 8,
              tabs: [
                RepeatedTab(label: 'Men'),
                RepeatedTab(label: 'Women'),
                RepeatedTab(label: 'Shoes'),
                RepeatedTab(label: 'Bags'),
                RepeatedTab(label: 'Electronics'),
                RepeatedTab(label: 'Accessories'),
                RepeatedTab(label: 'Home & Garden'),
                RepeatedTab(label: 'Kids'),
                RepeatedTab(label: 'Beauty'),
              ]),
        ),
        body: const TabBarView(children: [
          // Center(child: Text('men screen')),
          MenGalleryScreen(),
          WomenGalleryScreen(),
          ShoesGalleryScreen(),
          BagsGalleryScreen(),
          ElectronicsGalleryScreen(),
          AccessoriesGalleryScreen(),
          HomeGardenGalleryScreen(),
          KidsGalleryScreen(),
          BeautyGalleryScreen(),
          // Center(child: Text('beauty screen')),
        ]),
      ),
    );
  }
}
