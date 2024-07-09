


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_details_apps/models/Ratings.dart';

part 'Products.freezed.dart';
part 'Products.g.dart';

@freezed
class Products with _$Products {
   const factory Products({
      required int id,
   required String title,
   required double price,
   required String description,
   required String category,
   required String image,
     required Ratings rating,
  }) = _Products;

   factory Products.fromJson(Map<String,dynamic> json) => _$ProductsFromJson(json);
}