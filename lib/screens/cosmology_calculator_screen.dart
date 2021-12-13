import 'package:flutter/material.dart';

import '../widgets/input_forms.dart';
import '../widgets/output_results.dart';

class CosmologyCalculatorScreen extends StatelessWidget {
  const CosmologyCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cosmology'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            InputForms(),
            Divider(),
            OutputResults(),
          ],
        ),
      ),
    );
  }
}
