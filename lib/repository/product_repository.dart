import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_details_apps/models/Products.dart';

class ProductService  {

  String url = "https://fakestoreapi.com/products";

  Future<List<Products>> getAllProductsDetails() async{
    try{
      var request = http.Request('GET', Uri.parse(url));
      http.StreamedResponse response = await request.send();

      var jsondata = await response.stream.bytesToString();
      List<dynamic> data = json.decode(jsondata);
      List<Products> productData = [];
      print("${data[0]}");
      for (var d in data) {

         productData.add(Products.fromJson(d));
      }
      return productData ;

    }catch(e){
      print("here error is $e");
      throw Exception(e);
    }
  }
}