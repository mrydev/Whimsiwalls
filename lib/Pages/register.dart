import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whimsiwalls/Pages/SignScreen.dart';
import 'package:whimsiwalls/Utils/bubbleBar.dart';
import 'package:whimsiwalls/Utils/mytextform.dart';

import '../Utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _emailErrorText = '';
  String _nameErrorText = '';
  String _passwordErrorText = '';
  String _confirmPasswordErrorText = '';

  void addUserInfoToFirestore(String uid, String name, String email) {
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      // Diğer kullanıcı bilgilerini buraya ekleyebilirsiniz
    });
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      addUserInfoToFirestore(
          userCredential.user!.uid, _nameController.text, email);
      // Kayıt başarılı, kullanıcı userCredential.user ile erişilebilir.

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignScreen()),
      );
    } catch (e) {
      // Kayıt sırasında bir hata oluştu.
    }
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _handleSignUp() {
    setState(() {
      _emailErrorText = '';
      _nameErrorText = '';
      _passwordErrorText = '';
      _confirmPasswordErrorText = '';

      String email = _emailController.text.trim();
      String name = _nameController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (email.isEmpty) {
        _emailErrorText = 'Email boş olamaz';
      }

      if (name.isEmpty) {
        _nameErrorText = 'Kullanıcı Adı boş olamaz';
      }

      if (password.isEmpty) {
        _passwordErrorText = 'Şifre boş olamaz';
      } else if (password.length < 8) {
        _passwordErrorText = 'Şifre 8 karakterden uzun olmalı';
      }

      if (confirmPassword.isEmpty) {
        _confirmPasswordErrorText = 'Tekrar Şifre boş olamaz';
      }

      if (password != confirmPassword && _confirmPasswordErrorText.isEmpty) {
        _confirmPasswordErrorText = 'Şifreler uyuşmuyor';
      }

      if (_emailErrorText.isEmpty &&
          _nameErrorText.isEmpty &&
          _passwordErrorText.isEmpty &&
          _confirmPasswordErrorText.isEmpty) {
        // Firebase signUp fonksiyonunu burada çağırabilirsiniz
        signUp(email, password);
      } else {
        // Şifre 8 karakterden kısa olduğunda Snackbar hatası gösterme
        if (_passwordErrorText.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_passwordErrorText),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const BubbleBar(),
            const SizedBox(height: 50),
            MyTextField(
              prefixIcon: const Icon(Icons.email),
              controller: _emailController,
              hintText: "Email",
              obscureText: false,
              error: _emailErrorText.isNotEmpty,
              errorText: _emailErrorText,
            ),
            const SizedBox(height: 20),
            MyTextField(
              prefixIcon: const Icon(Icons.person),
              controller: _nameController,
              hintText: "Kullanıcı Adı",
              obscureText: false,
              error: _nameErrorText.isNotEmpty,
              errorText: _nameErrorText,
            ),
            const SizedBox(height: 20),
            MyTextField(
              prefixIcon: const Icon(Icons.lock),
              controller: _passwordController,
              hintText: "Şifre",
              obscureText: true,
              error: _passwordErrorText.isNotEmpty,
              errorText: _passwordErrorText,
            ),
            const SizedBox(height: 20),
            MyTextField(
              prefixIcon: const Icon(Icons.lock),
              controller: _confirmPasswordController,
              hintText: "Tekrar Şifre",
              obscureText: true,
              error: _confirmPasswordErrorText.isNotEmpty,
              errorText: _confirmPasswordErrorText,
            ),
            const SizedBox(height: 40),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
              child: GestureDetector(
                onTap: () {
                  _handleSignUp();
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [MyColors.mor, MyColors.lila],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(64),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: Center(
                    child: Text(
                      "Register",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: MyColors.beyaz,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
