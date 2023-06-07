import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:whimsiwalls/Services/fetchData.dart';
import 'package:whimsiwalls/Utils/colors.dart';

import '../Services/fullScreenImage.dart';

class AiGenerated extends StatefulWidget {
  final bool showDefaultTitle;

  const AiGenerated({Key? key, this.showDefaultTitle = true}) : super(key: key);

  @override
  State<AiGenerated> createState() => _AiGeneratedState();
}

class _AiGeneratedState extends State<AiGenerated> {
  List<DocumentSnapshot>? documents;

  void fetchData() async {
    try {
      List<DocumentSnapshot> fetchedDocuments = await fetchDataFromFirestore();
      setState(() {
        documents = fetchedDocuments;
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.lavander.withOpacity(0.94),
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.showDefaultTitle ? 'WhimsiWalls' : 'A.I. Generated',
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
              if (documents != null)
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 2),
                    ),
                    itemCount: documents!.length,
                    itemBuilder: (BuildContext context, int index) {
                      String? url = documents![index].get('url');
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImagePage(
                                  imageUrl: documents![index]['url'],
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
      ),
    );
  }
}
