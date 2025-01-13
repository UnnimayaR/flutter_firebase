import 'package:flutter/material.dart';

Widget cartBuildMenuItem({
  required String name,
  required double price,
  required int calories,
  required int quantity,
  required VoidCallback onDecrease,
  required VoidCallback onIncrease,
  required bool isVeg,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 16,
          color: isVeg ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                '$calories calories',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1B4332),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onDecrease,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 15,
                ),
                padding: EdgeInsets.zero,
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              IconButton(
                onPressed: onIncrease,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 15,
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'INR ${price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}
