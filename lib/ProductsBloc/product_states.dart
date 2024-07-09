import 'package:flutter/cupertino.dart';

import '../models/Products.dart';

@immutable
class ProductStates {}

class ProductInitial extends ProductStates {}

class ProductsLoading extends ProductStates {
  final bool loading;
  ProductsLoading({required this.loading});
}

class ProductFetchedSuccessfully extends ProductStates {
  final List<Products>  productList;
  ProductFetchedSuccessfully({required this.productList});
}

class FailedToFetchProducts extends ProductStates {

}