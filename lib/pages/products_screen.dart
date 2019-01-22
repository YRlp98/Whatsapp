import 'package:flutter/material.dart';
import 'package:whatsapp/component/product_card.dart';
import 'package:whatsapp/models/product.dart';
import 'package:whatsapp/services/product_services.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [];
  int _currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProducts();
  }

  void _getProducts({int page = 1}) async {
    var response = await ProductService.getProducts(page);
    print(response['products']);

    setState(() {
      _products.addAll(response['products']);
      _currentPage = response['currentPage'];
    });
  }

//  Show Items as ListView
  Widget streamListView() {
    return new ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          return new ProductCard(product: _products[index]);
        });
  }

//  Show Items as GridView
  Widget moduleListView() {
    return new GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: const EdgeInsets.only(top: 0),
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          return new ProductCard(product: _products[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return moduleListView();
  }
}
