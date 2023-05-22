import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:horget/controller/data_handler/app_data.dart';
import 'package:horget/controller/render.dart';
import 'package:horget/view/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Good rider application',
        theme: ThemeData(
          scaffoldBackgroundColor: white,
          appBarTheme: const AppBarTheme(
            backgroundColor: black,
            titleTextStyle: style20,
            elevation: 0,
            centerTitle: false,
          ),
        ),
        home: const Home(),
      ),
    );
  }
}

