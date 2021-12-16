import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/universe.dart';
import '../providers/calculator.dart';

class SelectUniverse extends StatefulWidget {
  const SelectUniverse({Key? key}) : super(key: key);

  @override
  _SelectUniverseState createState() => _SelectUniverseState();
}

class _SelectUniverseState extends State<SelectUniverse> {
  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MODELS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  return calculator.selectUniverse(Universe.flat);
                },
                child: const Text(
                  'Flat',
                ),
                style: ElevatedButton.styleFrom(
                  primary: calculator.selectedModel == Universe.flat
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  return calculator.selectUniverse(Universe.open);
                },
                child: const Text('Open'),
                style: ElevatedButton.styleFrom(
                  primary: calculator.selectedModel == Universe.open
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  return calculator.selectUniverse(Universe.general);
                },
                child: const Text('General'),
                style: ElevatedButton.styleFrom(
                  primary: calculator.selectedModel == Universe.general
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
