import 'product_dto.dart';

abstract interface class ProductRepository {
  Future<Product> create(Product product);
  Future<List<Product>> findAll();
  Future<Product> findById(int id);
  Future<void> update(Product product);
  Future<void> delete(int id);
}
