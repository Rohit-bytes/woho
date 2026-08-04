import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:woho/core/colorpallete.dart';

class CustomBackButton extends StatelessWidget {
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

  const CustomBackButton({
    super.key,
    this.height = 50,
    this.width = 50,
    this.radius = 50,
    this.icon,
    this.iconSize = 16,
    this.text,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              color: backgroundColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: borderColor.withValues(alpha: 0.25),
                width: borderWidth,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (text != null)
                  Text(
                    text!,
                    style: TextStyle(
                      color: foregroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                if (text != null && icon != null) const SizedBox(width: 8),

                if (icon != null)
                  Icon(icon, size: iconSize, color: foregroundColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
