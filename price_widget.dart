import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double discountPrice;
  final double? rating;
  final bool showRating;

  const PriceWidget({
    super.key,
    required this.price,
    required this.discountPrice,
    this.rating,
    this.showRating = true,
  });

  bool get hasDiscount {
    return discountPrice > 0 && discountPrice < price;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Text(
          "৳${hasDiscount ? discountPrice.toStringAsFixed(0) : price.toStringAsFixed(0)}",
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        if (hasDiscount) ...[
          const SizedBox(width: 8),

          Text(
            "৳${price.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              fontSize: 13,
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "-${(((price - discountPrice) / price) * 100).round()}%",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],

        const Spacer(),

        if (showRating) ...[
          const Icon(
            Icons.star,
            color: Colors.orange,
            size: 18,
          ),

          const SizedBox(width: 3),

          Text(
            (rating ?? 5.0).toStringAsFixed(1),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
