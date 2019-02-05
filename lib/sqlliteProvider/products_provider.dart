import 'package:whatsapp/models/product.dart';
import 'package:whatsapp/sqlliteProvider/provider.dart';

class ProductsProvider extends Provider{
  String _tableName = 'products';

  Future<Product> insert(Product product) async{
    product.id = await db.insert(_tableName, product.toMap());
    return product;
  }
}