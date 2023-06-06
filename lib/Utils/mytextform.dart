import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final bool error;
  final String errorText;
  final Widget prefixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.error,
    required this.errorText,
     required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 1)
            ]),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            
              filled: true,
              fillColor: MyColors.beyaz2,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(64))),
              labelText: hintText,
              
              prefixIcon: prefixIcon,
              errorText: error ? errorText : null,
              errorStyle: GoogleFonts.poppins(
                color: MyColors.vibrantRed,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
    );
  }
}
