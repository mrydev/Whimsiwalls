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

  bool _emailError = false;
  bool _passError = false;

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
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomesPage()),
        );
      } else {
        setState(() {
          _emailError = true;
          _passError = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: MyColors.vibrantRed,
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: const Center(
              child: Text(
                'Giriş bilgileri hatalı.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _handleSignIn() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Bilgiler boş ise uyarı ver
      setState(() {
        _emailError = email.isEmpty;
        _passError = password.isEmpty;
      });
      return;
    }

    // Hata durumu düzeltildiğinde veya metinden çıkıldığında uyarıyı kapat
    setState(() {
      _emailError = false;
      _passError = false;
    });

    signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: MyColors.beyaz,
        body: Center(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
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
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.beyaz2,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(64))),
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        errorText: _emailError ? "Email boş olamaz" : null,
                        errorStyle: GoogleFonts.poppins(
                          color: MyColors.vibrantRed,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
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
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: MyColors.beyaz2,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(64))),
                        labelText: 'Password',
                        errorText: _passError ? "Şifre boş olamaz" : null,
                        prefixIcon: const Icon(Icons.key),
                        errorStyle: GoogleFonts.poppins(
                          color: MyColors.vibrantRed,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
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
                height: 100,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: GestureDetector(
                  onTap: () {
                    _handleSignIn();
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
                height: 30,
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
