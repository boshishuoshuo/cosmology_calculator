import 'dart:math';

import 'package:flutter/material.dart';

import '../models/universe.dart';

class Calculator with ChangeNotifier {
  final double Tyr = 977.8; //coefficent for converting 1/H into Gyr
  final double c = 299792.458; // velocity of light in km/sec
  final int n = 1000;
  Universe selectedModel = Universe.general;

  final Map<String, double?> _results = {
    'z': 3.0,
    'z2': 3.5,
    'mass': 10000000000.0,
    'H0': 75,
    'OmegaM': 0.3,
    'OmegaV': 0.0,
    'age_Gyr': 0.0,
    'zage_Gyr': 1.714,
    'DTT_Gyr': 0.0,
    'DCMR_Mpc': 0.0,
    'DCMR_Gyr': 0.0,
    'V_Gpc': 0.0,
    'DA_Mpc': 1425.0,
    'DA_Gyr': 4.6477,
    'kpc_DA': 0.0,
    'DL_Mpc': 22799.7,
    'DL_Gyr': 74.363,
    'distanceModulus': 0.0,
    'thetaE': 0.040,
  };

  Map<String, double?> get results {
    return {..._results};
  }

  double _az(double redshiftZ) {
    return 1.0 / (1 + 1.0 * redshiftZ);
  }

  double get _WV {
    switch (selectedModel) {
      case Universe.flat:
        {
          return 1.0 -
              _results['OmegaM']! -
              0.4165 / (_results['H0']! * _results['H0']!);
        }
      case Universe.open:
        {
          return 0.0;
        }
      case Universe.general:
        {
          return _results['OmegaV']!;
        }
    }
  }

  double get _h {
    return _results['H0']! / 100;
  }

  double get _WR {
    return 4.165e-5 / (_h * _h);
  }

  double get _WK {
    return 1 - _results['OmegaM']! - _WR - _WV;
  }

  double get _age {
    return _integralAge();
  }

  double get _zage {
    return _az(_results['z']!) * _age / n;
  }

  double get _DTT {
    return (1.0 - _az(_results['z']!)) *
        _integralDTTDCMR(azVal: _az(_results['z']!))['DTT']! /
        n;
  }

  double _DCMR(_azVal) {
    return (1.0 - _azVal) * _integralDTTDCMR(azVal: _azVal)['DCMR']! / n;
  }

  double get _V_Gpc {
    double ratio;
    double x = sqrt(_WK.abs()) * _DCMR(_az(_results['z']!));
    if (x > 0.1) {
      if (_WK > 0) {
        ratio = (0.125 * (exp(2.0 * x) - exp(-2.0 * x)) - x / 2.0) /
            (x * x * x / 3.0);
      } else {
        ratio = (x / 2.0 - sin(2.0 * x) / 4.0) / (x * x * x / 3.0);
      }
    } else {
      double y = x * x;
      if (_WK < 0) {
        y = -y;
      }
      ratio = 1.0 + y / 5.0 + (2.0 / 105.0) * y * y;
    }
    double VCM = ratio *
        _DCMR(_az(_results['z']!)) *
        _DCMR(_az(_results['z']!)) *
        _DCMR(_az(_results['z']!)) /
        3.0;
    return 4.0 * pi * (pow(0.001 * c / _results['H0']!, 3)) * VCM;
  }

  double _DA(double azVal) {
    double ratio;
    double x = sqrt(_WK.abs()) * _DCMR(azVal);
    if (x > 0.1) {
      if (_WK > 0) {
        ratio = 0.5 * (exp(x) - exp(-x)) / x;
      } else {
        ratio = sin(x) / x;
      }
    } else {
      double y = x * x;
      if (_WK < 0) {
        y = -y;
      }
      ratio = 1.0 + y / 6.0 + y * y / 120.0;
    }
    double DCMT = ratio * _DCMR(azVal);
    return azVal * DCMT;
  }

  double get _DL {
    return _DA(_az(_results['z']!)) /
        (_az(_results['z']!) * _az(_results['z']!));
  }

  void selectUniverse(Universe selectedUniverse) {
    selectedModel = selectedUniverse;
    notifyListeners();
  }

  void setParameter(Map<String, double?> inputValues) {
    _results['H0'] = inputValues['hubbleConst'];
    _results['OmegaM'] = inputValues['omegaMatter'];
    _results['OmegaV'] = inputValues['omegaVacuum'];
  }

  void calculate(double redshiftInputValue, double redshiftInputValue2,
      double massInputValue) {
    _results['z'] = redshiftInputValue;
    _results['z2'] = redshiftInputValue2;
    _results['mass'] = massInputValue;
    double age = _age;
    double zage = _zage;
    double DTT = _DTT;
    double DCMR = _DCMR(_az(_results['z']!));
    age = DTT + zage;
    double age_Gyr = age * (Tyr / _results['H0']!);
    double zage_Gyr = (Tyr / _results['H0']!) * zage;
    double DTT_Gyr = (Tyr / _results['H0']!) * DTT;
    double DCMR_Gyr = (Tyr / _results['H0']!) * DCMR;
    double DCMR_Mpc = (c / _results['H0']!) * DCMR;
    double DA_Mpc = (c / _results['H0']!) * _DA(_az(_results['z']!));
    double DA_Mpc2 = (c / _results['H0']!) * _DA(_az(_results['z2']!));
    double ds2s = (DA_Mpc2 - DA_Mpc) / DA_Mpc2;
    ds2s = ds2s.abs();
    double thetaE = sqrt(_results['mass']! *
        4.0 *
        6.67 *
        2.0 /
        (9 * 3.09) *
        ds2s /
        DA_Mpc *
        1e-19);
    thetaE = thetaE * 2.06e5;
    double DA_Gyr = (Tyr / _results['H0']!) * _DA(_az(_results['z']!));
    double kpc_DA = DA_Mpc / 206.264806;
    double DL_Mpc = (c / _results['H0']!) * _DL;
    double DL_Gyr = (Tyr / _results['H0']!) * _DL;
    double distanceModulus = 5 * (log(DL_Mpc * 1e6) / log(10)) - 5;
    _results['age_Gyr'] = age_Gyr;
    _results['zage_Gyr'] = zage_Gyr;
    _results['DTT_Gyr'] = DTT_Gyr;
    _results['DCMR_Gyr'] = DCMR_Gyr;
    _results['DCMR_Mpc'] = DCMR_Mpc;
    _results['V_Gpc'] = _V_Gpc;
    _results['DA_Mpc'] = DA_Mpc;
    _results['DA_Gyr'] = DA_Gyr;
    _results['kpc_DA'] = kpc_DA;
    _results['DL_Mpc'] = DL_Mpc;
    _results['DL_Gyr'] = DL_Gyr;
    _results['distanceModulus'] = distanceModulus;
    _results['thetaE'] = thetaE;
    notifyListeners();
  }

  Map<String, double> _integralDTTDCMR({
    int n = 1000,
    required double azVal,
  }) {
    double DTT = 0.0;
    double DCMR = 0.0;
    final double WMVal = _results['OmegaM']!;
    final double WVVal = _WV;
    final double WRVal = _WR;
    final double WKVal = _WK;
    for (int i = 0; i < n; i++) {
      double a = azVal + (1 - azVal) * (i + 0.5) / n;

      double adot =
          sqrt(WKVal + (WMVal / a) + (WRVal / (a * a)) + (WVVal * a * a));
      DTT = DTT + 1.0 / adot;
      DCMR = DCMR + 1.0 / (a * adot);
    }
    return {'DTT': DTT, 'DCMR': DCMR};
  }

  double _integralAge({
    int n = 1000,
  }) {
    double age = 0;
    final double azVal = _az(_results['z']!);
    final double WMVal = _results['OmegaM']!;
    final double WVVal = _WV;
    final double WRVal = _WR;
    final double WKVal = _WK;
    for (int i = 0; i < n; i++) {
      double a = azVal * (i + 0.5) / n;
      double adot =
          sqrt(WKVal + (WMVal / a) + (WRVal / (a * a)) + (WVVal * a * a));
      age = age + 1 / adot;
    }
    return age;
  }
}
