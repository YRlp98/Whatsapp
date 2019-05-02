import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/models/product.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleProductScreen extends StatelessWidget {
  final Product product;

  SingleProductScreen({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return new Directionality(
        textDirection: TextDirection.rtl,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text(product.title),
          ),
          body: new Column(
            children: <Widget>[
              new CachedNetworkImage(
                width: screenSize.width,
                height: 200,
                imageUrl: product.image,
                fit: BoxFit.cover,
              )
            ],
          ),
        ));
  }
}
