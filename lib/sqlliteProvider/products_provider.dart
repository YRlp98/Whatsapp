import 'package:sqflite/sqflite.dart';
import 'package:whatsapp/models/product.dart';
import 'package:whatsapp/sqlliteProvider/provider.dart';

class ProductsProvider extends Provider {
  String _tableName = 'products';

  Future<Product> insert(Product product,
      {conflictAlgorithm: ConflictAlgorithm.ignore}) async {
    product.id = await db.insert(_tableName, product.toMap(),
        conflictAlgorithm: conflictAlgorithm);
    return product;
  }

  Future<bool> insertAll(List<Product> products) async {
    await Future.wait(products.map((product) async {
      await this.insert(product);
    }));
    return true;
  }

  Future<List<Product>> paginate(int page, {int limit: 8}) async {
    List<Map> maps = await db.query(_tableName,
        columns: ['id', 'user_id', 'title', 'body', 'image'],
        limit: limit,
        offset: page == 1 ? 0 : (page - 1) * limit);

    if (maps.length > 0) {
      List<Product> products = [];
      maps.forEach((product) {
        if (product != null) {
          products.add(Product.fromJson(product));
        }
      });
      return products;
    }
    return null;
  }
}
