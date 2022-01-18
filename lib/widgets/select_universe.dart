import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import '../models/universe.dart';
import '../providers/calculator.dart';

class SelectUniverse extends StatefulWidget {
  const SelectUniverse({Key? key}) : super(key: key);

  @override
  _SelectUniverseState createState() => _SelectUniverseState();
}

class _SelectUniverseState extends State<SelectUniverse> {
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
    'omegaVacuum': 0.0
  };

  void _setPara() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    final calculator = Provider.of<Calculator>(context, listen: false);
    calculator.setParameter(
      _inputValue,
    );
  }

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
          const SizedBox(height: 14),
          Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 75,
                  width: 300,
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
                            style: const TextStyle(fontSize: 20),
                            initialValue: _initValue['hubbleConst'].toString(),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1.0,
                              )),
                            ),
                            textInputAction:
                                calculator.selectedModel == Universe.flat
                                    ? TextInputAction.done
                                    : TextInputAction.next,
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
                if (calculator.selectedModel != Universe.flat)
                  Container(
                    height: 75,
                    width: 300,
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
                              initialValue:
                                  _initValue['omegaMatter'].toString(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 1.0,
                                )),
                              ),
                              textInputAction:
                                  calculator.selectedModel == Universe.open
                                      ? TextInputAction.done
                                      : TextInputAction.next,
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
                                _inputValue['omegaMatter'] =
                                    double.parse(value!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (calculator.selectedModel == Universe.general)
                  Container(
                    height: 75,
                    width: 300,
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
                              initialValue:
                                  _initValue['omegaVacuum'].toString(),
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
                                    double.parse(value) >= 1.0) {
                                  return 'Please provide a value in (0, 1)';
                                }
                                return null; // treat input as right
                              },
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                _inputValue['omegaVacuum'] =
                                    double.parse(value!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _setPara,
                child: const Text('Set'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
