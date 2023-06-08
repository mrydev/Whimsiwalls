import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whimsiwalls/Catagories/reddit.dart';
import 'package:whimsiwalls/Catagories/stock.dart';
import 'package:whimsiwalls/Utils/mybutton.dart';

import '../Catagories/abstract.dart';
import '../Catagories/ai_generated.dart';
import '../Catagories/amoled.dart';
import '../Catagories/cars.dart';
import '../Utils/colors.dart';

class CatagoryList extends StatefulWidget {
  const CatagoryList({super.key});

  @override
  State<CatagoryList> createState() => _CatagoryListState();
}

class _CatagoryListState extends State<CatagoryList> {
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
          title: Text('Catagories',
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  letterSpacing: 5,
                  color: Colors.black.withOpacity(0.8))),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AiGenerated(showDefaultTitle: false),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'AI Generated',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ))),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Stock(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text('Stock',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 24)),
                      ))),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Reddit(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'From Reddit',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ))),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cars(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Cars',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ))),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Amoled(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Amoled',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ))),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Abstract(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Abstract',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
