import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/models/product.dart';

class ProductService {
  static Future<Map> getProducts(int page) async {
    final response = await http.get('http://roocket.org/api/products?page=${page}');

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body)['data'];

      List<Product> products = [];
      responseBody['data'].forEach((item) {
        products.add(Product.fromJson(item));
      });

      return {
        'current_page': responseBody['current_page'],
        'products': products
      };
    }
  }
}
