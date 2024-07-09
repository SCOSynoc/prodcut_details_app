import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_details_apps/AuthBLoc/auth_bloc.dart';
import 'package:product_details_apps/AuthBLoc/auth_events.dart';
import 'package:product_details_apps/AuthBLoc/auth_states.dart';
import 'package:product_details_apps/ProductsBloc/product_bloc.dart';
import 'package:product_details_apps/ProductsBloc/product_events.dart';
import 'package:product_details_apps/ProductsBloc/product_states.dart';
import 'package:product_details_apps/Utils/Helper.dart';
import 'package:product_details_apps/screens/Products_Details_Screen.dart';
import 'package:product_details_apps/widgets/AppearAnimatedWidget.dart';
import 'package:product_details_apps/widgets/Loading_Manager.dart';

import '../models/Products.dart';
import '../models/Users.dart';
import '../widgets/CommonText.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}


class _AllProductsScreenState extends State<AllProductsScreen> {
 bool isLoading = false;

  List<Products> products = [];

  ScrollController _scrollController = ScrollController();
  int _currentMax = 20;
  Users? currentUser;
  Stream<Users>? userStream;
  List<Products> data = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetAllProductsRequest());
    context.read<AuthBloc>().add(AuthUserDataRequested());
    _scrollController.addListener(() {
      context.read<AuthBloc>().add(AuthUserDataRequested());
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
         context.read<AuthBloc>().add(AuthUserDataRequested());
      }
    });
  }





  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<AuthBloc,AuthStates>(
      listener: (context,state) {
        if(state is AuthInitial) {
          context.read<AuthBloc>().add(AuthUserDataRequested());
        }
        if(state is AuthUserSuccess) {
          currentUser = state.user;
          userStream = state.userS;
        }
      },
      builder: (context,state) {
        return BlocConsumer<ProductBloc,ProductStates>(
          listener: (BuildContext context, ProductStates state) {
              if(state is ProductsLoading) {
                 isLoading = state.loading;

              }

              if(state is ProductFetchedSuccessfully) {
                products = state.productList;
                data = products;
                isLoading = false;

              }
          },
          builder: (context, state) {
            return LoadingManager(
              isLoading: isLoading,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Product List'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  MasonryGridView.count(
                        controller: _scrollController,
                        crossAxisCount: Helper.crossAxisCount(context: context),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) => AnimatedAppearWidget(
                          child: OpenContainer(
                            tappable: true,
                            closedShape:const RoundedRectangleBorder(borderRadius: BorderRadius.zero) ,
                            transitionType: ContainerTransitionType.fadeThrough,
                            closedElevation: 0,
                            openElevation: 4,
                            closedBuilder: (BuildContext context, void Function() action) {
                              return  Card(
                                    elevation: 10,
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CommonText( text:
                                            data[index].title,
                                              fontSize: 18, fontWeight: FontWeight.bold,titleText: true,
                                          ),
                                        ),
                                        Image.network(
                                          width: MediaQuery.of(context).size.width,
                                          "${data[index].image}",
                                          fit: BoxFit.scaleDown,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CommonText( text:
                                                '\$${data[index].price.toString()}',
                                                fontSize: 16,numericText: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: StreamBuilder<Users>(
                                                  stream: userStream ,
                                                  builder: (context, snapshot) {
                                                    return IconButton(
                                                      icon: Icon(snapshot.data != null && snapshot.data!.favouriteList.contains(json.encode(data[index])) ? Icons.favorite_outlined:
                                                      Icons.favorite_border,
                                                        color:snapshot.data != null && snapshot.data!.favouriteList.contains(json.encode(data[index])) ? Colors.red: null,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          /*products[index]['liked'] = !products[index]['liked'];*/
                                                          context.read<AuthBloc>().add(UpdateUserFavouriteList(favList: snapshot.data?.favouriteList ?? [], product: data[index]));
                                                          context.read<AuthBloc>().add(AuthUserDataRequested());
                                                        });
                                                      },
                                                    );
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  );
                            },
                            openBuilder: (BuildContext context, void Function({Object? returnValue}) action) {
                              return ProductsDetailsPage(products: data[index],);
                            },
                          ),
                        ),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      )

                ),
              ),
            );
          },
        );
      }
    );;
  }

}
