import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_details_apps/AuthBLoc/auth_states.dart';
import 'package:product_details_apps/ProductsBloc/product_events.dart';
import 'package:product_details_apps/ProductsBloc/product_states.dart';
import 'package:product_details_apps/repository/product_repository.dart';

import '../models/Products.dart';

class ProductBloc extends Bloc<ProductEvents,ProductStates> {
  ProductBloc(): super(ProductInitial()) {
    on<GetAllProductsRequest>(_onAllProductsRequested);

  }

  ProductService service = ProductService();

  void _onAllProductsRequested(GetAllProductsRequest event, Emitter<ProductStates> emit) async {
         emit(ProductsLoading(loading: true));
         await service.getAllProductsDetails().onError((e,s) {
           emit(ProductsLoading(loading: false));
           emit(FailedToFetchProducts());
           print("Here error is $e and stacktrace is $s");
           return [];
         }).then((v){
           emit(ProductsLoading(loading: false));
           emit(ProductFetchedSuccessfully(productList: v));
           return v;
         });

  }
}