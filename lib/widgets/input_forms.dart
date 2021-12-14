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
  Map<String, double> _initValue = {
    'redshift': 3.0,
    'hubbleConst': 75.0,
    'omegaMatter': 0.3,
  };

  Map<String, double> _inputValue = {
    'redshift': 0.0,
    'hubbleConst': 75.0,
    'omegaMatter': 3.0,
  };

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    final calculator = Provider.of<Calculator>(context, listen: false);
    calculator.calculate(
      _inputValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context);
    return Container(
      height: 350,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _form,
        child: ListView(
          children: [
            TextFormField(
              initialValue: _initValue['hubbleConst'].toString(),
              decoration: const InputDecoration(
                labelText: 'Hubble Constant',
              ),
              textInputAction: TextInputAction.next,
              // onFieldSubmitted: (_) {
              //   FocusScope.of(context).requestFocus(_priceFocusNode);
              // },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide a value'; // treat input as wrong input and show it to the user
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter only number.';
                }
                if (double.parse(value) < 0 || double.parse(value) >= 100) {
                  return 'Please provide a value in (0, 100)';
                }
                return null; // treat input as right
              },
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _inputValue['hubbleConst'] = double.parse(value!);
              },
            ),
            TextFormField(
              initialValue: _initValue['redshift'].toString(),
              decoration: const InputDecoration(
                labelText: 'Redshift',
              ),
              textInputAction: TextInputAction.next,
              // onFieldSubmitted: (_) {
              //   FocusScope.of(context).requestFocus(_priceFocusNode);
              // },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide a value'; // treat input as wrong input and show it to the user
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter only number.';
                }
                if (double.parse(value) < 0 || double.parse(value) >= 100) {
                  return 'Please provide a value in (0, 100)';
                }
                return null; // treat input as right
              },
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _inputValue['redshift'] = double.parse(value!);
              },
            ),
            if (calculator.selectedModel != Universe.flat)
              TextFormField(
                initialValue: _initValue['omegaMatter'].toString(),
                decoration: const InputDecoration(
                  labelText: 'Omega Matter',
                ),
                textInputAction: TextInputAction.next,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value'; // treat input as wrong input and show it to the user
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter only number.';
                  }
                  if (double.parse(value) < 0 || double.parse(value) >= 1.0) {
                    return 'Please provide a value in (0, 1)';
                  }
                  return null; // treat input as right
                },
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _inputValue['omegaMatter'] = double.parse(value!);
                },
              ),
            if (calculator.selectedModel == Universe.general)
              TextFormField(
                initialValue: _initValue['omegaVacuum'].toString(),
                decoration: const InputDecoration(
                  labelText: 'Omega Vacuum',
                ),
                textInputAction: TextInputAction.done,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_priceFocusNode);
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value'; // treat input as wrong input and show it to the user
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter only number.';
                  }
                  if (double.parse(value) < 0 || double.parse(value) >= 1.0) {
                    return 'Please provide a value in (0, 1)';
                  }
                  return null; // treat input as right
                },
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _inputValue['omegaVacuum'] = double.parse(value!);
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
