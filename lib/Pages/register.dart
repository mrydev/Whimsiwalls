import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:whimsiwalls/Pages/SignScreen.dart';
import 'package:whimsiwalls/Utils/mybutton.dart';
import 'package:whimsiwalls/Utils/mytextform.dart';

import '../Utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
      print(e.toString());
    }
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignUp() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Firebase signUp fonksiyonunu burada çağırabilirsiniz
    signUp(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.lavander,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_add_alt_1_rounded,
                size: 100,
                color: Colors.black,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text("Hello, Join Us!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 50,
              ),
              MyTextField(
                  controller: _emailController,
                  hintText: "Email",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: _nameController,
                  hintText: "NickName",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true),
              const SizedBox(
                height: 30,
              ),
              MyButton(onTap: _handleSignUp),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              //!google button
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200],
                      ),
                      child: Logo(
                        Logos.google,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
