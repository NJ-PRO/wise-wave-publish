import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisewave/animation/fade_animation.dart';
import 'package:wisewave/components/my_button.dart';
import 'package:wisewave/components/my_textfield.dart';
import 'package:wisewave/components/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editior controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FadeAnimation(
          1.5,
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfff2c2b1), Color(0xffe5a8b6)])),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/final-logo-of-wise-wave.png',
                      fit: BoxFit.cover,
                      width: 500,
                      height: 250,
                    ),

                    //Email
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),

                    const SizedBox(height: 20),

                    //Password
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 23),

                    //login button
                    MyButton(
                      onTap: signUserIn,
                    ),

                    const SizedBox(height: 20),

                    //or
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: const Divider(
                              thickness: 2,
                              color: Color(0xff000000),
                              height: 36,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            'or',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 0.5,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: const Divider(
                              thickness: 2,
                              color: Color(0xff000000),
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Material(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: ListTile(
                        title: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Login with Google",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        leading: Image.asset('assets/images/Google.png'),
                        onTap: () => AuthService().signInWithGoogle(context),
                        tileColor: const Color(0xFFFFFFFF),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),

                    //signup
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          // onTap: () {
                          //   Navigator.pushNamed(context, '/signup');
                          // },
                          onTap: widget.onTap,
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4CA59F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
