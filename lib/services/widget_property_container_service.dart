import 'package:flutter/material.dart';

// Helper function to create a container with formatted text
Widget propertyContainer(
    String label, String value, double containerWidth, Color borderColor) {
  return Container(
    width: containerWidth,
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.only(bottom: 8.0),
    decoration: BoxDecoration(
      border: Border.all(
        color: borderColor,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ],
    ),
  );
}
