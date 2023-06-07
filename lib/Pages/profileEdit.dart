import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whimsiwalls/Utils/mybutton.dart';
import 'package:whimsiwalls/Utils/mytextform.dart';

import '../Utils/colors.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final user = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController();
  final ppUrlController = TextEditingController();

  void updateUserName() async {
    final usersRef = FirebaseFirestore.instance.collection('users');

    await usersRef.doc(user?.uid).update({
      'name': nameController.text,
    });
  }

  void updateProfilePictureUrl() async {
    final usersRef = FirebaseFirestore.instance.collection('users');

    await usersRef.doc(user?.uid).update({
      'ppUrl': ppUrlController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lavander,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profil Düzenleme',
            style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 4,
                color: Colors.black.withOpacity(0.8))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 120),
            MyTextField(
              controller: nameController,
              hintText: "Yeni kullanıcı adı",
              obscureText: false,
              error: false,
              errorText: "errorText",
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 20),
            MyButton(
                onTap: updateUserName,
                child: Center(
                    child: Text(
                  'Kullanıcı Adı Güncelle',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ))),
            const SizedBox(height: 60),
            MyTextField(
              controller: ppUrlController,
              hintText: "Yeni profil resmi URL",
              obscureText: false,
              error: false,
              errorText: "",
              prefixIcon: const Icon(Icons.image),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
                onTap: updateProfilePictureUrl,
                child: Center(
                    child: Text(
                  'Profil Resmi Güncelle',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ))),
          ],
        ),
      ),
    );
  }
}
