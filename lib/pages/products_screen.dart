import 'package:flutter/material.dart';
import 'package:whatsapp/component/product_card.dart';
import 'package:whatsapp/models/product.dart';
import 'package:whatsapp/services/product_services.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProductsScreenState();
}

//with AutomaticKeepAliveClientMixin<ProductsScreen>
class ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [];
  int _currentPage = 1;
  bool _viewStream = true;
  bool _isLoading = true;
  ScrollController _listScrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProducts();
    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

      if (maxScroll - currentScroll <= 200) {
        if (!_isLoading) {
          _getProducts(page: _currentPage + 1);
        }
      }
    });
  }

  void _getProducts({int page = 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await ProductService.getProducts(page);

    setState(() {
      if (refresh) _products.clear();

      _products.addAll(response['products']);
      _currentPage = response['current_page'];
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

  Future<Null> _handleRefresh() async {
    await _getProducts(refresh: true);
    return null;
  }

//  Show Items as ListView
  Widget streamListView() {
    return _products.length == 0 && _isLoading == true
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : new RefreshIndicator(
                child: new ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new ProductCard(product: _products[index]);
                    }),
                onRefresh: _handleRefresh);
  }

//  Show Items as GridView
  Widget moduleListView() {
    return _products.length == 0 && _isLoading == true
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : new RefreshIndicator(
                child: new GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new ProductCard(product: _products[index]);
                    }),
                onRefresh: _handleRefresh);
  }

  Widget headList() {
    return new SliverAppBar(
      primary: false,
      pinned: true,
      backgroundColor: Colors.white54,
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
        controller: _listScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return _products.length != 0 ? <Widget>[headList()] : [];
        },
        body: _viewStream ? streamListView() : moduleListView());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
