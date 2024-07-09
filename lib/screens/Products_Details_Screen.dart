
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_details_apps/widgets/CommonText.dart';
import 'package:product_details_apps/widgets/RatingBar.dart';

import '../models/Products.dart';

class ProductsDetailsPage extends StatefulWidget {
  const ProductsDetailsPage({super.key, required this.products});
  final Products products;

  @override
  State<ProductsDetailsPage> createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,
      surfaceTintColor: Colors.transparent,),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.network(widget.products.image),
              ),
              const SizedBox(height: 20,),
              CommonText(text: widget.products.title,descriptionText: true, fontSize: 32,),
              const SizedBox(height: 10,),
              CommonText(text: widget.products.category,titleText: true, fontSize: 25,),
              const SizedBox(height: 10,),
              CommonText(text: widget.products.description, descriptionText: true,),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(text: "\$${widget.products.price}", numericText: true, fontWeight: FontWeight.bold,),
                  Row(
                    children: [
                      RatingStars(rating: widget.products.rating.rate,),
                      CommonText(text: '(${widget.products.rating.count})')
                    ],
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
