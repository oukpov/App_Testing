import 'package:flutter/material.dart';

import 'future/pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
        "/": (context) => const HomeScreen(),
      },
      // home: Testing(),
    );
  }
}
//flutter test integration_test/E2E_test.dart