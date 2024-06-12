// lib/widgets/segmented_control.dart
import 'package:flutter/material.dart';

class SegmentedControl extends StatelessWidget {
  final List<String> segments;
  final String selectedSegment;
  final ValueChanged<String> onSegmentChanged;

  SegmentedControl({
    required this.segments,
    required this.selectedSegment,
    required this.onSegmentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: segments.map((segment) {
        bool isSelected = selectedSegment == segment;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSegmentChanged(segment),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                segment,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
