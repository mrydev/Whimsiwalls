import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:whimsiwalls/Catagories/stock.dart';
import 'package:whimsiwalls/Catagories/ai_generated.dart';
import 'package:whimsiwalls/Pages/catagories.dart';

import '../Utils/colors.dart';

class MyHomesPage extends StatefulWidget {
  const MyHomesPage({super.key});

  @override
  State<MyHomesPage> createState() => _MyHomesPageState();
}

class _MyHomesPageState extends State<MyHomesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: MyColors.lavander,
          appBar: AppBar(
            backgroundColor: MyColors.lavander.withOpacity(0.94),
            elevation: 0,
            centerTitle: true,
            title: Text('WHIMSIWALLS',
                style: GoogleFonts.raleway(
                    letterSpacing: 5,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 32)),
          ),
          body: const Column(children: [
            TabBar(tabs: [
              Tab(
                icon: Icon(Iconsax.home),
              ),
              Tab(
                icon: Icon(Iconsax.category),
              ),
              Tab(
                icon: Icon(Iconsax.profile_2user),
              ),
            ]),
            Expanded(
                child: TabBarView(
                    children: [AiGenerated(), CatagoryList(), Stock()]))
          ]),
        ));
  }
}
