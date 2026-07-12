import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          InkWell(
            onTap: onDecrease,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              child: const Icon(
                Icons.remove,
                size: 20,
              ),
            ),
          ),

          Container(
            width: 45,
            alignment: Alignment.center,
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          InkWell(
            onTap: onIncrease,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              child: const Icon(
                Icons.add,
                size: 20,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
