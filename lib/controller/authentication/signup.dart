import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:horget/controller/authentication/signin.dart';
import '../../view/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  Future signUp() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
        setState(() {
          _isLoading = true;
        });
        await FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(_auth.currentUser!.uid)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phone': phoneController.text,
          'uid': _auth.currentUser!.uid,
          'terms': 'agree',
          'policy': 'agree',
        }).then((value) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }).onError((error, stackTrace) {
          print('Data added problem => ${error.runtimeType.toString()}');
          setState(() {
            _isLoading = false;
          });
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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(hintText: "Phone"),
                ),
                const SizedBox(height: 15),
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
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                            signUp();
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
                              "Sign Up",
                              style: TextStyle(
                                  fontFamily: "Product Sans",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: const Text(
                    "Already have an account? Sign In",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Product Sans",
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
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
