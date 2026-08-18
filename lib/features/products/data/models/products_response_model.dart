import 'package:json_annotation/json_annotation.dart';
import 'package:shop_ease/features/products/data/models/product_model.dart';
import 'package:shop_ease/features/products/domain/entities/products_page.dart';

part 'products_response_model.g.dart';

@JsonSerializable()
class ProductsResponseModel {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  ProductsResponseModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseModelToJson(this);

  ProductsPage toEntity() => ProductsPage(
    products: products.map((m) => m.toEntity()).toList(),
    total: total,
    skip: skip,
    limit: limit,
  );
}
