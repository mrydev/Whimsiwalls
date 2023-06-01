import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whimsiwalls/Utils/colors.dart';

import '../Catagories/ai_generated.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lavander,
      appBar: AppBar(
        backgroundColor: MyColors.lavander,
        title: Text(style: GoogleFonts.inter(), 'Giriş Ekranı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı', labelStyle: GoogleFonts.inter()),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Parola', labelStyle: GoogleFonts.inter()),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Giriş butonuna basıldığında yapılacak işlemler

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const AiGenerated()));
              },
              child: Text(style: GoogleFonts.inter(), 'Giriş'),
            ),
          ],
        ),
      ),
    );
  }
}
