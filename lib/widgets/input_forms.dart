import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import '../providers/calculator.dart';

class InputForms extends StatefulWidget {
  const InputForms({Key? key}) : super(key: key);

  @override
  _InputFormsState createState() => _InputFormsState();
}

class _InputFormsState extends State<InputForms> {
  final int Omega = 0x03A9;
  final int Lambda = 0x039B;
  final _form = GlobalKey<FormState>();
  final Map<String, double> _initValue = {
    'hubbleConst': 75.0,
    'omegaMatter': 0.3,
    'omegaVacuum': 0.0,
  };

  final Map<String, double> _inputValue = {
    'hubbleConst': 75.0,
    'omegaMatter': 0.3,
    'omegaVacuum': 0.0,
  };

  final double _redshiftInitValue = 3.0;
  final double _redshiftInitValue2 = 3.5;
  final double _massInitValue = 10000000000.0;

  double _redshiftInputValue = 0.0;
  double _redshiftInputValue2 = 0.0;
  double _massInputValue = 0.0;

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    final calculator = Provider.of<Calculator>(context, listen: false);
    calculator.setParameter(
      _inputValue,
    );
    calculator.calculate(
      _redshiftInputValue,
      _redshiftInputValue2,
      _massInputValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 75,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 40,
                    child: Tooltip(
                      message: 'Hubble constant',
                      child: EasyRichText(
                        'H0 :',
                        patternList: [
                          EasyRichTextPattern(
                            targetString: '0',
                            subScript: true,
                            matchWordBoundaries: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: const Key('hubbleConst'),
                        style: const TextStyle(fontSize: 20),
                        initialValue: _initValue['hubbleConst'].toString(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1.0,
                          )),
                        ),
                        textInputAction: TextInputAction.next,
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
                          _inputValue['hubbleConst'] = double.parse(value!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 75,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 40,
                    child: Tooltip(
                      message: 'Omega(matter)',
                      child: EasyRichText(
                        '${String.fromCharCode(Omega)}M :',
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'M',
                            subScript: true,
                            matchWordBoundaries: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        initialValue: _initValue['omegaMatter'].toString(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1.0,
                          )),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value'; // treat input as wrong input and show it to the user
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter only number.';
                          }
                          if (double.parse(value) < 0 ||
                              double.parse(value) >= 1.0) {
                            return 'Please provide a value in (0, 1)';
                          }
                          return null; // treat input as right
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _inputValue['omegaMatter'] = double.parse(value!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 75,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 40,
                    child: Tooltip(
                      message: 'Omega(vacuum) or lambda',
                      child: EasyRichText(
                        '${String.fromCharCode(Omega)}${String.fromCharCode(Lambda)} :',
                        patternList: [
                          EasyRichTextPattern(
                            targetString: String.fromCharCode(Lambda),
                            subScript: true,
                            matchWordBoundaries: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        initialValue: _initValue['omegaVacuum'].toString(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1.0,
                          )),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value'; // treat input as wrong input and show it to the user
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter only number.';
                          }
                          if (double.parse(value) < 0 ||
                              double.parse(value) >= 1.0) {
                            return 'Please provide a value in (0, 1)';
                          }
                          return null; // treat input as right
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _inputValue['omegaVacuum'] = double.parse(value!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'redshift',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Container(
              height: 75,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      width: 40,
                      child: Tooltip(
                        message: 'redshift 1',
                        child: EasyRichText(
                          'z1 :',
                          patternList: [
                            EasyRichTextPattern(
                              targetString: '1',
                              subScript: true,
                              matchWordBoundaries: false,
                            ),
                          ],
                        ),
                      )),
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
                        textInputAction: TextInputAction.next,
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
            Container(
              height: 75,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      width: 40,
                      child: Tooltip(
                        message: 'redshift 2',
                        child: EasyRichText(
                          'z2 :',
                          patternList: [
                            EasyRichTextPattern(
                              targetString: '2',
                              subScript: true,
                              matchWordBoundaries: false,
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        initialValue: _redshiftInitValue2.toString(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1.0,
                          )),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value'; // treat input as wrong input and show it to the user
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter only number.';
                          }
                          if (double.parse(value) < _redshiftInputValue) {
                            return 'Please provide a value larger than z1';
                          }
                          return null; // treat input as right
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _redshiftInputValue2 = double.parse(value!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'lens mass',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Container(
              height: 75,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      width: 60,
                      child: const Tooltip(
                        message: 'lens mass',
                        child: Text('mass :'),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 20),
                        initialValue: _massInitValue.toString(),
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
                          if (double.parse(value) < 1 ||
                              double.parse(value) >= 1000000000000000) {
                            return 'Please provide a value in (1, 1e15)';
                          }
                          return null; // treat input as right
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _massInputValue = double.parse(value!);
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
