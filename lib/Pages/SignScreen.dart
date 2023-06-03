import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:whimsiwalls/Pages/homes.dart';
import 'package:whimsiwalls/Pages/register.dart';
import 'package:whimsiwalls/Utils/colors.dart';
import 'package:whimsiwalls/Utils/mybutton.dart';
import 'package:whimsiwalls/Utils/mytextform.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signIn(String email, String password) async {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomesPage()),
      );

      // Giriş başarılı, kullanıcı userCredential.user ile erişilebilir.
    } catch (e) {
      ToastDetails.error();
      // Giriş sırasında bir hata oluştu.
      print(e.toString());
    }
  }

  void _handleSignIn() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Firebase signIn fonksiyonunu burada çağırabilirsiniz
    signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lavander,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //!logo
                const Icon(
                  (OctIcons.shield_lock_24),
                  size: 100,
                  color: Colors.black,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                const Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),
                //!textfields
                MyTextField(
                  controller: _emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                //!sign in button
                MyButton(
                  onTap: _handleSignIn,
                ),
                const SizedBox(height: 50),

                //!or
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
                Row(
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
                const SizedBox(height: 30),

                //!not a member? sign up
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member? ",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
