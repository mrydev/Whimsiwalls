import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whimsiwalls/Utils/colors.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  bool isLiked = false;

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
          style: GoogleFonts.inter(),
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
                    isLiked = !isLiked;
                  });
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? MyColors.pinkShades : Colors.black,
                  size: 32,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.champagne,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    changeWallpaper();
                  },
                  child: Text(
                    'Duvar Kağıdı Yap',
                    style: GoogleFonts.inter(color: MyColors.grey),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
