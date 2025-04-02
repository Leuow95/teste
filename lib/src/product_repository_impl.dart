import 'package:postgres/postgres.dart';
import 'package:vaden/vaden.dart';

import 'product_dto.dart';
import 'product_repository.dart';

@Repository()
class ProductRepositoryImpl implements ProductRepository {
  final Connection _connection;
  final DSON dson;

  ProductRepositoryImpl(this._connection, this.dson);

  @override
  Future<List<Product>> findAll() async {
    try {
      final result = await _connection.execute(
        'SELECT * FROM products',
        ignoreRows: false,
      );

      final products = result.map((row) {
        final data = row.toColumnMap();
        return dson.fromJson<Product>(data);
      }).toList();

      return products;
    } catch (e) {
      throw Exception('Database error: $e');
    }
  }

  @override
  Future<Product> findById(int id) async {
    try {
      final result = await _connection.execute(
        'SELECT id, name, price FROM products WHERE id = @id',
        parameters: {'id': id},
        ignoreRows: false,
      );

      if (result.isEmpty) {
        throw Exception('Product not found');
      }

      final data = result.first.toColumnMap();
      return dson.fromJson<Product>(data);
    } catch (e) {
      throw Exception('Database error: $e');
    }
  }

  @override
  Future<Product> create(Product product) async {
    try {
      final sql = Sql.named('INSERT INTO products (name, price) VALUES (@name, @price) RETURNING id');

      final parameters = {
        'name': product.name,
        'price': product.price,
      };

      final result = await _connection.execute(
        sql,
        parameters: parameters,
        ignoreRows: false,
      );
      print(result);

      final id = result.first.toColumnMap()['id'];
      return Product(id: id, name: product.name, price: product.price);
    } catch (e) {
      throw Exception('Database error: $e');
    }
  }

  @override
  Future<void> update(Product product) async {
    try {
      // Serializa o produto para JSON usando o DSON
      final productData = dson.toJson(product);

      // Executa a consulta SQL para atualizar um produto existente
      await _connection.execute(
        'UPDATE products SET name = @name, price = @price WHERE id = @id',
        parameters: {
          'id': productData['id'],
          'name': productData['name'],
          'price': productData['price'],
        },
        ignoreRows: true,
      );
    } catch (e) {
      throw Exception('Database error: $e');
    }
  }

  Future<void> delete(int id) async {
    try {
      // Executa a consulta SQL para remover um produto pelo ID
      await _connection.execute(
        'DELETE FROM products WHERE id = @id',
        parameters: {'id': id},
        ignoreRows: true,
      );
    } catch (e) {
      throw Exception('Database error: $e');
    }
  }
}
