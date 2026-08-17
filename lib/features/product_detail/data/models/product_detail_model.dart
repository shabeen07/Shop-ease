import 'package:json_annotation/json_annotation.dart';

import 'package:shop_ease/features/product_detail/domain/entities/product_detail.dart';

part 'product_detail_model.g.dart';

@JsonSerializable()
class ProductDetailModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? brand;
  final String sku;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final String? returnPolicy;
  final String thumbnail;
  final List<String> images;

  ProductDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.sku,
    required this.thumbnail,
    required this.images,
    this.brand,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.returnPolicy,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);

  ProductDetail toEntity() => ProductDetail(
    id: id,
    title: title,
    description: description,
    category: category,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    brand: brand ?? '',
    sku: sku,
    warrantyInformation: warrantyInformation ?? '',
    shippingInformation: shippingInformation ?? '',
    availabilityStatus: availabilityStatus ?? '',
    returnPolicy: returnPolicy ?? '',
    thumbnail: thumbnail,
    images: images,
  );
}
