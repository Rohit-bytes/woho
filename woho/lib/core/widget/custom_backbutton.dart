import 'package:flutter/material.dart';
import 'package:woho/core/colorpallete.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;

  final IconData? icon;
  final double iconSize;
  final String? text;

  final Color backgroundColor;
  final Color foregroundColor;

  // Border
  final Color borderColor;
  final double borderWidth;

  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    this.height = 45,
    this.width,
    this.radius = 14,
    this.icon,
    this.iconSize = 22,
    this.text,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.secondary,
              ColorPalette.primary,
              const Color.fromARGB(255, 57, 218, 17),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text first
            if (text != null)
              Text(
                text!,
                style: TextStyle(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

            // Gap between text and icon
            if (text != null && icon != null) const SizedBox(width: 8),

            // Icon after text
            if (icon != null)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(icon, size: iconSize, color: ColorPalette.primary),
              ),
          ],
        ),
      ),
    );
  }
}
