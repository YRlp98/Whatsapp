import 'package:flutter/material.dart';
import 'package:whatsapp/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    return new Text(product.title);
  }
}
