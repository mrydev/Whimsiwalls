import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    // Firestore'dan favoriler koleksiyonundaki belgeleri kullanıcının UID'sine göre filtreleyerek çek
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    if (uid != null) {
      QuerySnapshot querySnapshot = await firestore
          .collection('favs')
          .doc(uid)
          .collection('favorites')
          .get();

      // Elde edilen belgeleri döndür
      return querySnapshot.docs;
    } else {
      return [];
    }
  } catch (e) {
    // Hata durumunda ilgili işlemleri yap
    print('Hata: $e');
    return [];
  }
}