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
            'For H0 = ${calculator.results['H0']}, OmegaM = ${calculator.results['OmegaM']}, z = ${calculator.results['z']}:'),
        Text(
            'It is now ${calculator.results['age_Gyr']} Gyr since the Big Bang.'),
        Text(
            'The age at redshift z was ${calculator.results['zage_Gyr']} Gyr.'),
        Text('The light travel time was ${calculator.results['DTT_Gyr']} Gyr.'),
        Text('The comoving radial distance, which goes into Hubbles law, is,'),
        Text(
            '${calculator.results['DCMR_Mpc']} Mpc or ${calculator.results['DCMR_Gyr']} Gly.'),
        Text(
            'The comoving volume within redshift z is ${calculator.results['V_Gpc']} Gpc^3.'),
        Text(
            'The angular size distance D_A is ${calculator.results['DA_Mpc']} Mpc or,'),
        Text('${calculator.results['DA_Gyr']} Gly.'),
        Text('This gives a scale of ${calculator.results['kpc_DA']} kpc/".'),
        Text(
            'The luminosity distance D_L is ${calculator.results['DL_Mpc']} Mpc or ${calculator.results['DL_Gyr']} Gly.'),
        Text(
            'The distance modulus, m-M, is ${calculator.results['distanceModulus']}'),
      ],
    );
  }
}
