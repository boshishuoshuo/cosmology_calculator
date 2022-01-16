import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator.dart';
import '../models/universe.dart';

class InputForms extends StatefulWidget {
  const InputForms({Key? key}) : super(key: key);

  @override
  _InputFormsState createState() => _InputFormsState();
}

class _InputFormsState extends State<InputForms> {
  final _form = GlobalKey<FormState>();
  final double _redshiftInitValue = 3.0;

  double _redshiftInputValue = 0.0;

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    final calculator = Provider.of<Calculator>(context, listen: false);
    calculator.calculate(
      _redshiftInputValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INPUTS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Container(
              height: 75,
              width: 300,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      width: 40,
                      child: const Tooltip(
                          message: 'redshift', child: Text('z :'))),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        initialValue: _redshiftInitValue.toString(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1.0,
                          )),
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value'; // treat input as wrong input and show it to the user
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter only number.';
                          }
                          if (double.parse(value) < 0 ||
                              double.parse(value) >= 100) {
                            return 'Please provide a value in (0, 100)';
                          }
                          return null; // treat input as right
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _redshiftInputValue = double.parse(value!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
