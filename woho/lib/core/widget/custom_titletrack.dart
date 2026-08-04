import 'package:flutter/material.dart';
import 'package:woho/core/colorpallete.dart';

class CustomSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomSectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: ColorPalette.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: ColorPalette.primary, size: 16),
        ),

        const SizedBox(width: 9),

        Text(
          title,
          style: TextStyle(
            color: ColorPalette.primary,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}
