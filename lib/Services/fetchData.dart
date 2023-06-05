import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> fetchDataFromFirestore() async {
  // Firestore bağlantısını başlat
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Firestore'dan verileri çek
    QuerySnapshot querySnapshot =
        await firestore.collection('wallpapers').get();

    // Elde edilen belgeleri döndür
    return querySnapshot.docs;
  } catch (e) {
    // Hata durumunda ilgili işlemleri yap
    print('Hata: $e');
    return [];
  }
}

Future<List<DocumentSnapshot>> fetchAiFromFirestore() async {
  // Firestore bağlantısını başlat
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Firestore'dan 'ai' koleksiyonundaki verileri çek
    QuerySnapshot querySnapshot =
        await firestore.collection('stockwallpapers').get();

    // Elde edilen belgeleri döndür
    return querySnapshot.docs;
  } catch (e) {
    // Hata durumunda ilgili işlemleri yap
    print('Hata: $e');
    return [];
  }
}


Future<List<DocumentSnapshot>> fetchFavsFromFirestore() async {
  // Firestore bağlantısını başlat
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Firestore'dan 'ai' koleksiyonundaki verileri çek
    QuerySnapshot querySnapshot =
        await firestore.collection('favs').get();

    // Elde edilen belgeleri döndür
    return querySnapshot.docs;
  } catch (e) {
    // Hata durumunda ilgili işlemleri yap
    print('Hata: $e');
    return [];
  }
}