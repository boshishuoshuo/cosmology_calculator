import 'dart:math';

import 'package:flutter/material.dart';

class Calculator with ChangeNotifier {
  double z = 1;
  double H0 = 75;
  double WM = 0.3;
  late double az = 1.0 / (1 + 1.0 * z);
  late double WV = 1.0 - WM - 0.4165 / (H0 * H0);
  late double h = H0 / 100;
  late double WR = 4.165e-5 / (h * h);
  late double WK = 1 - WM - WR - WV;
  double Tyr = 977.8;
  int n = 1000;

  Map<String, double?> _results = {
    'age_Gyr': 0.0,
  };

  Map<String, double?> get results {
    return {..._results};
  }

  void updateAgeGyr() {
    double age = _integralAge();
    double zage = az * age / n;

    Map<String, double> DTT_DCMR_map = _integralDTTDCMR();
    double DTT = (1.0 - az) * DTT_DCMR_map['DTT']! / n;
    age = DTT + zage;
    double age_Gyr = age * (Tyr / H0);
    _results['age_Gyr'] = age_Gyr;
    notifyListeners();
  }

  Map<String, double> _integralDTTDCMR({
    int n = 1000,
  }) {
    double DTT = 0.0;
    double DCMR = 0.0;
    for (int i = 0; i < n; i++) {
      double a = az + (1 - az) * (i + 0.5) / n;

      double adot = sqrt(WK + (WM / a) + (WR / (a * a)) + (WV * a * a));
      if (i == 0) {}
      // if (i == 0) {
      //   print(DTT);
      // }
      DTT = DTT + 1.0 / adot;
      DCMR = DCMR + 1.0 / (a * adot);
    }
    return {'DTT': DTT, 'DCMR': DCMR};
  }

  double _integralAge({
    int n = 1000,
  }) {
    double age = 0;
    for (int i = 0; i < n; i++) {
      double a = az * (i + 0.5) / n;
      double adot = sqrt(WK + (WM / a) + (WR / (a * a)) + (WV * a * a));
      age = age + 1 / adot;
    }
    return age;
  }
}
