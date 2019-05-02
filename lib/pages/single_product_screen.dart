import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              ),
              new Padding(
                padding: const EdgeInsets.all(10),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(product.title,
                            style: new TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        new Text(
                          'قیمت: ${product.price} تومان',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    new FlatButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        String apiToken = prefs.getString('user.api_toekn');
//                        String url =
//                            "http://roocket.org/api/product/buy?product_id=1&api_token=${apiToken}";
                        String url = "https://zarinp.al/@yrlp98";

                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: new Text(
                        'خرید محصول',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: new Text(product.body),
              )
            ],
          ),
        ));
  }
}
