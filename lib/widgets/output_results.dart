import 'dart:ui';

import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import "package:charcode/ascii.dart";

import '../providers/calculator.dart';

class OutputResults extends StatelessWidget {
  const OutputResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<Calculator>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OUTPUTS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: 'luminosity distance',
                      child: EasyRichText(
                        'DL :',
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'L',
                            subScript: true,
                            matchWordBoundaries: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Tooltip(
                      message: 'angular size distance',
                      child: EasyRichText(
                        'DA :',
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'A',
                            subScript: true,
                            matchWordBoundaries: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Tooltip(
                      message: 'the age at redshift z',
                      child: EasyRichText(
                        'tage :',
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'age',
                            subScript: true,
                            matchWordBoundaries: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Tooltip(
                      message: 'Einstein radius',
                      child: EasyRichText(
                        '${String.fromCharCode($Theta)}E :',
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'E',
                            subScript: true,
                            matchWordBoundaries: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${calculator.results['DL_Mpc']!.toStringAsFixed(1)} Mpc / ${calculator.results['DL_Gyr']!.toStringAsFixed(3)} Gly'),
                    const SizedBox(height: 6),
                    Text(
                        '${calculator.results['DA_Mpc']!.toStringAsFixed(1)} Mpc / ${calculator.results['DA_Gyr']!.toStringAsFixed(4)} Gly'),
                    const SizedBox(height: 6),
                    Text(
                        '${calculator.results['zage_Gyr']!.toStringAsFixed(3)} Gyr'),
                    const SizedBox(height: 6),
                    Text(
                        '${calculator.results['thetaE']!.toStringAsFixed(3)} arcsec'),
                  ],
                ),
              ),
            ],
          )
          // Text(
          //     'For H0 = ${calculator.results['H0']}, OmegaM = ${calculator.results['OmegaM']}, z = ${calculator.results['z']}:'),
          // Text(
          //     'It is now ${calculator.results['age_Gyr']} Gyr since the Big Bang.'),
          // Text(
          //     'The age at redshift z was ${calculator.results['zage_Gyr']} Gyr.'),
          // Text(
          //     'The light travel time was ${calculator.results['DTT_Gyr']} Gyr.'),
          // Text(
          //     'The comoving radial distance, which goes into Hubbles law, is,'),
          // Text(
          //     '${calculator.results['DCMR_Mpc']} Mpc or ${calculator.results['DCMR_Gyr']} Gly.'),
          // Text(
          //     'The comoving volume within redshift z is ${calculator.results['V_Gpc']} Gpc^3.'),
          // Text(
          //     'The angular size distance D_A is ${calculator.results['DA_Mpc']} Mpc or,'),
          // Text('${calculator.results['DA_Gyr']} Gly.'),
          // Text('This gives a scale of ${calculator.results['kpc_DA']} kpc/".'),
          // Text(
          //     'The luminosity distance D_L is ${calculator.results['DL_Mpc']} Mpc or ${calculator.results['DL_Gyr']} Gly.'),
          // Text(
          //     'The distance modulus, m-M, is ${calculator.results['distanceModulus']}'),
        ],
      ),
    );
  }
}
