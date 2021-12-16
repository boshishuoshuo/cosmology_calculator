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

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmology Calculator',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF46cad1)),
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 22),
          bodyText2: TextStyle(fontSize: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 16),
              onPrimary: Colors.white),
        ),
      ),
      home: const CosmologyCalculatorScreen(),
    );
  }
}
