import 'package:flutter/material.dart';
import 'package:whatsapp/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:whatsapp/pages/single_product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleProductScreen(
                      product: product,
                    )));
      },
      child: new Container(
        margin: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
        child: new Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            new Container(
              height: 200,
              width: screenSize.width,
              child: new CachedNetworkImage(
                width: screenSize.width,
                height: 200,
                imageUrl: product.image,
                fit: BoxFit.fill,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            new Container(
                alignment: Alignment.centerRight,
                height: 60,
                decoration: new BoxDecoration(color: Colors.black45),
                child: new Padding(
                  padding: const EdgeInsets.only(right: 15, left: 5),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//            Products Title
                      new Text(product.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
//            Products Body
                      new RichText(
                        maxLines: 1,
                        text: TextSpan(
                            text: product.body,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: 'Vazir')),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
