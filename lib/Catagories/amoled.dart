import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:whimsiwalls/Services/fetchData.dart';
import 'package:whimsiwalls/Utils/colors.dart';

import '../Services/fullScreenImage.dart';

class Amoled extends StatefulWidget {
  const Amoled({super.key});

  @override
  State<Amoled> createState() => _AmoledState();
}

class _AmoledState extends State<Amoled> {
  List<DocumentSnapshot>? amoled;

  void fetchData() async {
    try {
      List<DocumentSnapshot> aiData = await fetchAmoledFromFirestore();
      setState(() {
        amoled = aiData;
      });
    } catch (error) {
      print('Hata: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.lavander.withOpacity(0.94),
        elevation: 0,
        centerTitle: true,
        title: Text('Amoled',
            style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 5,
                color: Colors.black.withOpacity(0.8))),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.lavander,
      body: Center(
        child: Column(
          children: [
            if (amoled != null)
              Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: (1 / 2)),
                      itemCount: amoled!.length,
                      itemBuilder: (BuildContext context, int index) {
                        String? url = amoled![index].get('url');
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FullScreenImagePage(
                                                imageUrl: amoled![index]
                                                    ['url'])));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                    imageUrl: url!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.white,
                                            child: Container(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error)),
                              )),
                        );
                      })),
          ],
        ),
      ),
    );
  }
}
