import 'package:flutter/material.dart';

import 'colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Widget child;

  const MyButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [MyColors.mor, MyColors.lila],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(64),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 10,
                      spreadRadius: 1)
                ]),
            child: child,
          ),
        ));
  }
}
