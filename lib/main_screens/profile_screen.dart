import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sat_app/customer_screens/customer_orders.dart';
import 'package:sat_app/customer_screens/wishlist.dart';
import 'package:sat_app/main_screens/cart_screen.dart';
import 'package:sat_app/widgets/alert_dialog/my_alert_dialog.dart';
import 'package:sat_app/widgets/app_bar_widgets.dart/app_bar_back_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);
  final String documentId;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          return Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Stack(children: [
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.yellow,
                    Colors.brown,
                  ])),
                ),
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      elevation: 0,
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      expandedHeight: 140,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          return FlexibleSpaceBar(
                            title: AnimatedOpacity(
                              duration: Duration(milliseconds: 200),
                              opacity:
                                  constraints.biggest.height <= 120 ? 1 : 0,
                              child: Text(
                                'Account',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            background: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.brown,
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 30),
                                child: Row(
                                  children: [
                                    data['profileimage'] == ''
                                        ? CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                                'images/inapp/guest.jpg'),
                                          )
                                        : CircleAvatar(
                                            radius: 50,
                                            // backgroundImage:
                                            //     AssetImage('images/inapp/guest.jpg'),
                                            backgroundImage: NetworkImage(
                                                data['profileimage']),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text(
                                        // 'Guest'.toUpperCase(),
                                        data['name'] == ''
                                            ? 'Guest'.toUpperCase()
                                            : data['name'].toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Center(
                                          child: Text(
                                            'Cart',
                                            style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CartScreen(
                                              back: AppBarBackButtonWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    color: Colors.yellow,
                                    child: TextButton(
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Center(
                                          child: Text(
                                            'Orders',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerOrders(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.206,
                                        child: Center(
                                          child: Text(
                                            'Wishlist',
                                            style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WishlistScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: Image(
                                    image: AssetImage('images/inapp/logo.jpg'),
                                  ),
                                ),
                                ProfileHeaderLabel(
                                    headerLabel: ' Account Info. '),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      children: [
                                        RepeatedListTile(
                                          title: 'Email Address',
                                          // subTitle: 'example@email.com',
                                          subTitle: data['email'] == ''
                                              ? 'Anonymous email'
                                              : data['email'],
                                          icon: Icons.email,
                                          // onPressed: () {},
                                        ),
                                        // ListTile(
                                        //   leading: Icon(Icons.email),
                                        //   title: Text('Email Address'),
                                        //   subtitle: Text('example@email.com'),
                                        // ),
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(horizontal: 40),
                                        //   child: Divider(
                                        //     thickness: 1,
                                        //     color: Colors.yellow,
                                        //   ),
                                        // ),
                                        YellowDivider(),
                                        // ListTile(
                                        //   leading: Icon(Icons.phone),
                                        //   title: Text('Phone No.'),
                                        //   subtitle: Text('+996554123456789'),
                                        // ),
                                        RepeatedListTile(
                                          title: 'Phone No.',
                                          subTitle: data['phone'] == ''
                                              ? 'Anonymous phone'
                                              : data['phone'],
                                          icon: Icons.phone,
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(horizontal: 40),
                                        //   child: Divider(
                                        //     thickness: 1,
                                        //     color: Colors.yellow,
                                        //   ),
                                        // ),
                                        YellowDivider(),

                                        // ListTile(
                                        //   leading: Icon(Icons.location_pin),
                                        //   title: Text('Address'),
                                        //   subtitle: Text('example:120, - st - New York'),
                                        // ),
                                        RepeatedListTile(
                                          title: 'Address',
                                          // subTitle:
                                          // 'example:120, - st - New York',
                                          subTitle: data['address'] == ' '
                                              ? 'Anonymous address '
                                              : data['address'],
                                          icon: Icons.location_pin,
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ProfileHeaderLabel(
                                    headerLabel: ' Account Settings '),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      children: [
                                        RepeatedListTile(
                                          title: 'EditProfile',
                                          subTitle: '',
                                          icon: Icons.edit,
                                          onPressed: () {},
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(horizontal: 40),
                                        //   child: Divider(
                                        //     thickness: 1,
                                        //     color: Colors.yellow,
                                        //   ),
                                        // ),
                                        YellowDivider(),
                                        // InkWell(
                                        //   onTap: () {},
                                        //   child: ListTile(
                                        //     leading: Icon(Icons.phone),
                                        //     title: Text('Phone No.'),
                                        //     // subtitle: Text(''),
                                        //   ),
                                        // ),
                                        RepeatedListTile(
                                          title: 'Change Password',
                                          icon: Icons.lock,
                                          onPressed: () {},
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(horizontal: 40),
                                        //   child: Divider(
                                        //     thickness: 1,
                                        //     color: Colors.yellow,
                                        //   ),
                                        // ),
                                        YellowDivider(),
                                        // ListTile(
                                        //   leading: Icon(Icons.location_pin),
                                        //   title: Text('Address'),
                                        // ),
                                        RepeatedListTile(
                                          title: 'Log Out',
                                          icon: Icons.logout,
                                          onPressed: () async {
                                            MyAlertDialog.showMyDialog(
                                              context: context,
                                              title: 'Log Out',
                                              content:
                                                  "Are you sure want to log out?",
                                              tabNo: () =>
                                                  Navigator.of(context).pop(),
                                              tabYes: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                Navigator.pop(context);
                                                Navigator.pushReplacementNamed(
                                                    context, '/welcome_screen');
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]));
        }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      },
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        thickness: 1,
        color: Colors.yellow,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  const RepeatedListTile({
    Key? key,
    required this.title,
    this.subTitle = '',
    required this.icon,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subTitle),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  const ProfileHeaderLabel({
    Key? key,
    required this.headerLabel,
  }) : super(key: key);
  final String headerLabel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          Text(
            headerLabel,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
// profileHeaderLabel
