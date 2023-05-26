import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whimsiwalls/Services/fetchData.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WhimsiWalls'),
      ),
      body: Center(
        child: Column(
          children: [
            if (documents != null)
              Expanded(
                child: ListView.builder(
                  itemCount: documents!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Image.network(
                        documents![index]['url'],
                        filterQuality: FilterQuality.low,
                      )),
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
