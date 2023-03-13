import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  static void showMyDialog({
    required BuildContext context,
    required String title,
    required String content,
    required Function() tabNo,
    required Function() tabYes,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(title),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
              content: new Text(content),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("No"),
                  onPressed: tabNo,
                ),
                CupertinoDialogAction(
                  child: Text("Yes"),
                  onPressed: tabYes,
                ),
              ],
            ));
  }
}
