import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator.dart';

class OutputResults extends StatelessWidget {
  const OutputResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context);
    return Column(
      children: [
        Text(
            'It is now ${calculator.results['age_Gyr']} Gyr since the Big Bang.'),
      ],
    );
  }
}
