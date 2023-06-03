// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whimsiwalls/Catagories/stock.dart';
import 'package:whimsiwalls/Catagories/ai_generated.dart';
import 'package:whimsiwalls/Pages/SignScreen.dart';
import 'package:whimsiwalls/Pages/catagories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // List<DocumentSnapshot> documents = await fetchDataFromFirestore();

  // if (documents.isNotEmpty) {
  //   // Veriler mevcutsa, işlemleri gerçekleştir
  //   for (var document in documents) {
  //     // Her belgeyi kontrol etmek için döngü kullanabilirsiniz
  //     print('Belge ID: ${document.id}');
  //     print('Belge Verileri: ${document.data()}');
  //   }
  // } else {
  //   // Veri yoksa uygun bir mesaj yazdır
  //   print('Veri bulunamadı.');
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhimsiWalls',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignScreen(),
      routes: {
        "/catagories": (context) => const CatagoryList(),
        "/home": (context) => const AiGenerated(),
        "/stockwallpapers": (context) => const Stock(),
        "/signup": (context) => const AiGenerated(),
      },
    );
  }
}
