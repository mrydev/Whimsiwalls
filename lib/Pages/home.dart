import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: MyColors.cornsilk,
      appBar: AppBar(
        backgroundColor: MyColors.cornsilk,
        centerTitle: true,
        title: const Text('WhimsiWalls'),
      ),
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
                                      builder: (context) => FullScreenImagePage(
                                          imageUrl: documents![index]['url'])));
                            },
                            child: Container(
                                height: 960,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(url!),
                                        fit: BoxFit.cover))),
                          ),
                        );
                      })),
          ],
        ),
      ),
    );
  }
}
