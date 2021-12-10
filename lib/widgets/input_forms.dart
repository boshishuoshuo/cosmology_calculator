import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator.dart';

class InputForms extends StatefulWidget {
  const InputForms({Key? key}) : super(key: key);

  @override
  _InputFormsState createState() => _InputFormsState();
}

class _InputFormsState extends State<InputForms> {
  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context, listen: false);
    calculator.updateAgeGyr();
    return Text('This is going to be the input forms');
  }
}
