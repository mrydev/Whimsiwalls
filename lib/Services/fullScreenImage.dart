import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whimsiwalls/Utils/colors.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    isFavorite = false; // Değişiklik burada yapıldı

    if (uid != null) {
      final CollectionReference favsCollection =
          FirebaseFirestore.instance.collection('favs');

      favsCollection
          .doc(uid)
          .collection('favorites')
          .where('imageUrl', isEqualTo: widget.imageUrl)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          setState(() {
            isFavorite = true;
          });
        }
      });
    }
  }

  Future<void> changeWallpaper() async {
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);

    bool result = await AsyncWallpaper.setWallpaperFromFile(
      filePath: file.path,
      wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
      goToHome: true,
      toastDetails: ToastDetails.success(),
      errorToastDetails: ToastDetails.error(),
    );

    if (result) {
      print('Arka plan duvarı başarıyla değiştirildi.');
    } else {
      print('Arka plan duvarı değiştirilemedi.');
    }
  }

  void addToFavorites() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;

    if (uid != null) {
      final CollectionReference favsCollection =
          FirebaseFirestore.instance.collection('favs');

      if (!isFavorite) {
        favsCollection.doc(uid).collection('favorites').add({
          'imageUrl': widget.imageUrl,
          'timestamp': DateTime.now(),
        }).then((value) {
          setState(() {
            isFavorite = true;
          });
          print("Veri başarıyla eklendi!");
        }).catchError((error) {
          print("Veri eklenirken bir hata oluştu: $error");
        });
      } else {
        favsCollection
            .doc(uid)
            .collection('favorites')
            .where('imageUrl', isEqualTo: widget.imageUrl)
            .get()
            .then((value) {
          for (var doc in value.docs) {
            favsCollection
                .doc(uid)
                .collection('favorites')
                .doc(doc.id)
                .delete()
                .then((value) {
              setState(() {
                isFavorite = false;
              });
              print('Veri başarıyla silindi!');
            }).catchError((error) {
              print('Veri silinirken bir hata oluştu: $error');
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lavander,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.lavander,
        centerTitle: true,
        title: Text(
          'WhimsiWalls',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: MyColors.lavander,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    addToFavorites();
                  });
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? MyColors.pinkShades : Colors.black,
                  size: 32,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.champagne,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    changeWallpaper();
                  },
                  child: Text(
                    "Set Wallpaper",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
