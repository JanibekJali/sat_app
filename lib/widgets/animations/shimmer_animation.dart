import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: Duration(milliseconds: 800),
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
            ),
            title: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Container(
                color: Colors.grey[300],
              ),
            ),
            subtitle: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Container(
                color: Colors.grey[300],
              ),
            ),
          );
        },
      ),
    );
  }
}
