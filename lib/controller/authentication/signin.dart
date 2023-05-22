import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horget/controller/authentication/signup.dart';
import 'package:horget/controller/db/firebase_service.dart';
import '../../view/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  Future signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final user = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
        setState(() {
          _isLoading = true;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        setState(() {
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Unauthenticated"),
          ),
        );
       setState(() {
         _isLoading = false;
       });
      }
    } on FirebaseException catch (e) {
      print("${e.message.toString()}");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = FirebaseService();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: "Product Sans",
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                          provider.signIn(context, emailController.text,
                              passwordController.text);
                        });
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Product Sans",
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text(
                  "Don't have an account? SignUp",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Product Sans",
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
