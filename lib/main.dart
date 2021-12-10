import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cosmology_calculator_screen.dart';
import './providers/calculator.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Calculator(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmology Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CosmologyCalculatorScreen(),
    );
  }
}
