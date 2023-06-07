import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/fetchData.dart';
import '../Services/fullScreenImage.dart';
import '../utils/colors.dart';

class Favs extends StatefulWidget {
  const Favs({Key? key}) : super(key: key);

  @override
  State<Favs> createState() => _FavsState();
}

class _FavsState extends State<Favs> {
  List<DocumentSnapshot>? favsWallpapers;

  void fetchData() async {
    try {
      List<DocumentSnapshot> favsData = await fetchFavsFromFirestore();
      setState(() {
        favsWallpapers = favsData;
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
        title: Text(
          'Favorites',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.lavander,
      body: Center(
        child: Column(
          children: [
            if (favsWallpapers != null)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 2,
                  ),
                  itemCount: favsWallpapers!.length,
                  itemBuilder: (BuildContext context, int index) {
                    String? url = favsWallpapers![index].get('imageUrl');
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImagePage(
                                imageUrl: favsWallpapers![index]['imageUrl'],
                              ),
                            ),
                          );
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
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
