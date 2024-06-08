import 'package:flutter/material.dart';
import 'package:smaill_project/future/pages/ListAll.dart';

import 'package:smaill_project/future/pages/homepage.dart';
import 'package:smaill_project/future/pages/test.dart';

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
      home: const HomePage(),
      // home: ListAll(
      //   listModel: const [
      //     {'id': 1, 'items': 'Avocados', 'checks': 0},
      //     {'id': 2, 'items': 'Cranberry', 'checks': 0},
      //     {'id': 3, 'items': 'Dragonfruit', 'checks': 0},
      //     {'id': 4, 'items': 'Finger lime', 'checks': 0},
      //     {'id': 5, 'items': 'Grapefruit', 'checks': 0},
      //     {'id': 6, 'items': 'Horned melon', 'checks': 0},
      //     {'id': 7, 'items': 'Indian fig', 'checks': 0},
      //     {'id': 8, 'items': 'Jackfruit', 'checks': 0},
      //     {'id': 9, 'items': 'Kiwi', 'checks': 0},
      //     {'id': 10, 'items': 'Mango', 'checks': 0},
      //     {'id': 11, 'items': 'Muskmelon', 'checks': 0},
      //     {'id': 12, 'items': 'Nectarine', 'checks': 0},
      //     {'id': 13, 'items': 'Olive', 'checks': 0},
      //     {'id': 14, 'items': 'Papaya', 'checks': 0},
      //     {'id': 15, 'items': 'Pomegranate', 'checks': 0},
      //     {'id': 16, 'items': 'Raspberries', 'checks': 0},
      //     {'id': 17, 'items': 'Tangerine', 'checks': 0},
      //   ],
      // ),
      // home: Testing(),
    );
  }
}
