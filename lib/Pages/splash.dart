import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whimsiwalls/Pages/loginPage.dart';
import 'package:whimsiwalls/Utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Duration değeri, splash ekranın ne kadar süreyle gösterileceğini belirler
  // Bu süre bittiğinde ana ekran açılacak
  final splashDuration = 3; // 3 saniye

  // initState metodu, Stateful widget'ın başlatıldığı zaman çalışır
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: splashDuration), () {
      // Navigator ile yeni bir sayfaya geçiş yapabilirsiniz
      // Örneğin, ana ekranınızın olduğu bir sayfaya geçmek için:
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Splash ekranın arkaplan rengini veya görüntüsünü ayarlayabilirsiniz
      backgroundColor: MyColors.cornsilk,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.fill,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
