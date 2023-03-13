import 'package:flutter/material.dart';
import 'package:sat_app/widgets/app_bar_widgets.dart/app_bar_title_widget.dart';
import 'package:sat_app/widgets/carts_widgets/yellow_button_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
    this.back,
  }) : super(key: key);
  final Widget? back;
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            // leading: AppBarBackButtonWidget(),

            leading: widget.back,
            backgroundColor: Colors.white,
            title: const AppBarTitleWidget(title: 'Cart'),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your Cart Is Empty!',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(25),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () {
                      Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : Navigator.pushReplacementNamed(
                              context, '/customer_home_screen');
                    },
                    child: const Text(
                      'Continue shopping',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      'Total: \$',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '00.00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                YellowButtonWidget(
                  label: 'CHECK OUT',
                  onPressed: () {},
                  width: 0.45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
