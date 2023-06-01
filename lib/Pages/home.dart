import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:whimsiwalls/Services/fetchData.dart';
import 'package:whimsiwalls/Utils/colors.dart';

import 'fullScreenImage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DocumentSnapshot>? documents;
  List<DocumentSnapshot>? stockWallpapers;

  void fetchData() async {
    try {
      List<DocumentSnapshot> aiData = await fetchAiFromFirestore();
      setState(() {
        stockWallpapers = aiData;
      });

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
        // Başlangıçta seçili olan sekmenin indeksi

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
                                crossAxisCount: 2, childAspectRatio: (1 / 2)),
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
                                          builder: (context) =>
                                              FullScreenImagePage(
                                                  imageUrl: documents![index]
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
      ),
    );
  }
}
