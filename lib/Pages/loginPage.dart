import 'package:flutter/material.dart';
import 'package:whimsiwalls/Utils/colors.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cornsilk,
      appBar: AppBar(
        backgroundColor: MyColors.cornsilk,
        title: const Text('Giriş Ekranı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Parola'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Giriş butonuna basıldığında yapılacak işlemler

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const MyHomePage()));
              },
              child: const Text('Giriş'),
            ),
          ],
        ),
      ),
    );
  }
}
