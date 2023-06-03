import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        title: const Text("Register"),
      ),
      body: const Center(child: Text("Register")),
    );
  }
}
