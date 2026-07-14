import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxlength;
  final bool showCounter;

  /// Set true for phone number field
  final bool isPhoneNumber;

  /// Returns complete number like +919876543210
  final Function(String)? onPhoneChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.showCounter = false,
    this.maxlength = 100,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.isPhoneNumber = false,
    this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isPhoneNumber) {
      return IntlPhoneField(
        disableLengthCheck: true,
        controller: controller,
        initialCountryCode: 'IN',
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.black,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (phone) {
          onPhoneChanged?.call(phone.completeNumber);
        },
      );
    }

    return TextField(
      controller: controller,
      maxLength: maxlength,
      autocorrect: true,

      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: Icon(prefixIcon),
        filled: true,
        counterText: showCounter ? null : "",
        fillColor: Colors.black,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
