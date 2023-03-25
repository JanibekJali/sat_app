import 'package:flutter/material.dart';
import 'package:sat_app/minor_screens/product_details_screen.dart';

class ProductModel extends StatelessWidget {
  const ProductModel({
    super.key,
    required this.products,
  });
  final dynamic products;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(proList: products),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: 250,
                  ),
                  child: Image.network(
                    // snapshot.data!.docs[index]['proimages'][0],
                    products['proimages'][0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      // snapshot.data!.docs[index]['proname'],
                      products['proname'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // snapshot.data!.docs[index]['price'].toStringAsFixed(2) +
                          //     (' \$'),
                          products['price'].toStringAsFixed(2) + (' \$'),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
