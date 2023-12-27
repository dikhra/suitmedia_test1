import 'package:flutter/material.dart';
import 'package:suitmedia_test/screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Suitmedia Test 1', home: FirstScreen());
  }
}
