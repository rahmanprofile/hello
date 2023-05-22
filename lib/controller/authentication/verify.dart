import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horget/view/home.dart';

import '../render.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _phoneVerifyController = TextEditingController();
  final system = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(system);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Code', style:style25),
              const Text('Please confirm your phone number', style: style16),
              const Text('and enter your code', style: style16),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _phoneVerifyController,
                style: style16,
                decoration: const InputDecoration(
                  hintText: "Enter code",
                  hintStyle: style16,
                  focusColor: Colors.black,
                ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Home()));
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Text("Confirm", style: style15),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      'By signup you agree our all terms and conditions policy',
                      style: styleB13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('if want to know more?', style: styleB13),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          ' click here.',
                          style: GoogleFonts.raleway(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
