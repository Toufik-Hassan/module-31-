import 'package:flutter/material.dart';

class CategoryProductScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: const Center(
        child: Text("Category Products"),
      ),
    );
  }
}
