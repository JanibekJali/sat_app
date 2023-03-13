import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sat_app/dashboard_components/edit_business.dart';
import 'package:sat_app/dashboard_components/manage_products.dart';
import 'package:sat_app/dashboard_components/my_store.dart';
import 'package:sat_app/dashboard_components/supplier_balance.dart';
import 'package:sat_app/dashboard_components/supplier_orders.dart';
import 'package:sat_app/dashboard_components/supplier_statics.dart';
import 'package:sat_app/widgets/alert_dialog/my_alert_dialog.dart';
import 'package:sat_app/widgets/app_bar_widgets.dart/app_bar_title_widget.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics'
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];
List<Widget> pages = [
  MyStore(),
  SupplierOrders(),
  EditBusiness(),
  ManageProducts(),
  BalanceScreen(),
  StaticsScreen(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: AppBarTitleWidget(
          title: 'Dashboard',
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyAlertDialog.showMyDialog(
                context: context,
                title: 'Log Out',
                content: "Are you sure want to log out?",
                tabNo: () => Navigator.of(context).pop(),
                tabYes: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/welcome_screen');
                },
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.purpleAccent,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                  children: [
                    Icon(
                      icons[index],
                      size: 50,
                      color: Colors.yellowAccent,
                    ),
                    Text(
                      label[index].toUpperCase(),
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        fontFamily: 'Acme',
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
