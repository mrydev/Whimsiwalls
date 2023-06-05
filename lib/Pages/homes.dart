import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:whimsiwalls/Catagories/ai_generated.dart';
import 'package:whimsiwalls/Pages/catagories.dart';
import 'package:whimsiwalls/Pages/profile.dart';

import '../Utils/colors.dart';

class MyHomesPage extends StatefulWidget {
  const MyHomesPage({Key? key}) : super(key: key);

  @override
  State<MyHomesPage> createState() => _MyHomesPageState();
}

class _MyHomesPageState extends State<MyHomesPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const AiGenerated(),
    const CatagoryList(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lavander,
      // appBar: AppBar(
      //   backgroundColor: MyColors.lavander.withOpacity(0.94),
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     'WHIMSIWALLS',
      //     style: GoogleFonts.raleway(
      //       letterSpacing: 5,
      //       color: Colors.black.withOpacity(0.8),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 32,
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Expanded(
            child: _pages[_selectedIndex],
          ),
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_2user),
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
