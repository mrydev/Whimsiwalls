import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whimsiwalls/Pages/homes.dart';
import 'package:whimsiwalls/Utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _auth = auth.FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      checkCurrentUser();
    });
  }

  Future<void> checkCurrentUser() async {
    auth.User? user = _auth.currentUser;
    if (user != null) {
      // Kullanıcı zaten kimlik doğrulandı, ana sayfaya yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomesPage()),
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcı doğrulama işlemi başarılı olduysa
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomesPage()),
        );
      } else {
        ToastDetails.error();
        // Kullanıcı doğrulama işlemi başarısız olduysa
        print("Kullanıcı doğrulama hatası");
      }
    } catch (e) {
      ToastDetails.error();
      // Giriş sırasında bir hata oluştu.
      print(e.toString());
    }
  }

  void _handleSignIn() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Bilgiler boş ise işlem yapma
      return;
    }

    signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: MyColors.beyaz,
        body: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const BubbleBar(),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(64),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: MyColors.beyaz2,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(64))),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email)),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(64),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: MyColors.beyaz2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(64))),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Forgot Password?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgot");
                        },
                        child: const Text("Reset"))
                  ],
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: GestureDetector(
                  onTap: () {},
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
                      "LOGIN",
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: MyColors.beyaz),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 110,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: const Text("Sign up"))
                ],
              )
            ],
          ),
        ));
  }
}

class BubbleBar extends StatelessWidget {
  const BubbleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(128),
        ),
        gradient: LinearGradient(colors: [
          MyColors.mor,
          MyColors.lila,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Center(
          child: Image.network(
              "https://cdn.discordapp.com/attachments/1111721823466430464/1115378473486258216/00003-2024031808.0-removebg.png")),
    );
  }
}
