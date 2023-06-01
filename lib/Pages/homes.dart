import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whimsiwalls/Pages/home.dart';
import 'package:whimsiwalls/Pages/homep.dart';
import 'package:whimsiwalls/Pages/stockWallpapers.dart';

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
            title: Text('WhimsiWalls', style: GoogleFonts.inter()),
          ),
          body: const Column(children: [
            TabBar(tabs: [
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Catagories',
              ),
              Tab(
                text: 'Profile',
              ),
            ]),
            Expanded(
                child: TabBarView(children: [
              MyHomePage(),
              CatagoryList(),
              StockWallpapers()
            ]))
          ]),
        ));
  }
}
