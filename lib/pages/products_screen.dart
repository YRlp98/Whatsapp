import 'package:flutter/material.dart';
import 'package:whatsapp/component/product_card.dart';
import 'package:whatsapp/models/product.dart';
import 'package:whatsapp/services/product_services.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen>
    with AutomaticKeepAliveClientMixin<ProductsScreen> {
  List<Product> _products = [];
  int _currentPage = 1;
  bool _viewStream = true;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProducts();
  }

  void _getProducts({int page = 1}) async {
    var response = await ProductService.getProducts(page);

    setState(() {
      _products.addAll(response['products']);
      _currentPage = response['currentPage'];
      _isLoading = false;
    });
  }

  Widget loadingView() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget listIsEmpty() {
    return new Center(
      child: new Text('OPS! There is no products to show'),
    );
  }

//  Show Items as ListView
  Widget streamListView() {
    return _products.length == 0 && _isLoading == true
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : new ListView.builder(
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

  Widget headList() {
    return new SliverAppBar(
      primary: false,
      pinned: false,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: <Widget>[
//        ViewStream Icon
        new Padding(
          padding: const EdgeInsets.only(left: 10),
          child: new GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = true;
              });
            },
            child: new Icon(
              Icons.view_stream,
              color: _viewStream ? Colors.grey[700] : Colors.grey[500],
            ),
          ),
        ),
//        ModuleStream icon
        new Padding(
          padding: const EdgeInsets.only(left: 10),
          child: new GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = false;
              });
            },
            child: new Icon(
              Icons.view_module,
              color: _viewStream ? Colors.grey[500] : Colors.grey[700],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return _products.length != 0 ? <Widget>[headList()] : [];
        },
        body: _viewStream ? streamListView() : moduleListView());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
