import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Center(
        child: Text(
          "Product ID : $productId",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
