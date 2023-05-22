import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horget/controller/authentication/signin.dart';
import '../../view/home.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance;
  bool _isLoading = false;
  get auth => _auth;
  get db => _db;
  get isLoading => _isLoading;

  Future signUp(context, String email, password, phone, name) async {
    _isLoading = true;
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        _isLoading = true;
        await FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(_auth.currentUser!.uid)
            .set({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'uid': _auth.currentUser!.uid,
          'terms': 'agree',
          'policy': 'agree',
        }).then((value) {
          _isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }).onError((error, stackTrace) {
          print('Data added problem => ${error.runtimeType.toString()}');
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Unauthenticated"),
          ),
        );
        _isLoading = false;
      }
    } on FirebaseException catch (e) {
      print("${e.message.toString()}");
      _isLoading = false;
    }
  }

  Future signIn( context, String email,password) async {
    _isLoading = true;
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
          _isLoading = true;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Unauthenticated"),
          ),
        );
          _isLoading = false;
      }
    } on FirebaseException catch (e) {
      print("${e.message.toString()}");
        _isLoading = false;
    }
  }


  Future signOut(context) async {
    try{
       await _auth.signOut();
       Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));

    }on FirebaseException catch (e) {
      print('Exception => ${e.message.toString()}');

    }
  }

}
