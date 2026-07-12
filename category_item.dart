import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../screens/category/category_product_screen.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductScreen(
              categoryId: category.id,
              categoryName: category.categoryName,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 85,
        child: Column(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.shade100,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: category.categoryImg.isNotEmpty
                    ? Image.network(
                        category.categoryImg,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.category,
                            color: Colors.green,
                            size: 30,
                          );
                        },
                      )
                    : const Icon(
                        Icons.category,
                        color: Colors.green,
                        size: 30,
                      ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              category.categoryName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
