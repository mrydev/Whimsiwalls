import 'package:flutter/material.dart';

import 'colors.dart';

class BubbleBar extends StatefulWidget {
  const BubbleBar({super.key});

  @override
  State<BubbleBar> createState() => _BubbleBarState();
}

class _BubbleBarState extends State<BubbleBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(128),
        ),
        gradient: LinearGradient(colors: [
          MyColors.mor,
          MyColors.lila,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Center(
          child: Image.network(
              "https://cdn.discordapp.com/attachments/1111721823466430464/1115378473486258216/00003-2024031808.0-removebg.png")),
    );
  }
}
