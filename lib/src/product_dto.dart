import 'package:vaden/vaden.dart';

@DTO()
class Product {
  final int? id;
  final String name;

  @UseParse(DoubleParse)
  final double price;

  Product({required this.id, required this.name, required this.price});
}

class DoubleParse extends ParamParse<double, String> {
  const DoubleParse();

  @override
  String toJson(double? param) {
    return param?.toString() ?? "";
  }

  @override
  double fromJson(String? json) {
    return double.tryParse(json ?? '') ?? 0.0;
  }
}
