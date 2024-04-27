import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class StatisticsState with ChangeNotifier {
  StatisticsState({
    required PowerStatEnum initialSelectedPowerStat,
    required PowerStats initialPowerStats,
  })  : _powerStats = initialPowerStats,
        _selectedPowerStat = initialSelectedPowerStat;
  PowerStatEnum _selectedPowerStat;
  final PowerStats _powerStats;

  PowerStatEnum get selectedPowerStat => _selectedPowerStat;
  PowerStats get powerStats => _powerStats;

  void setSelectedPowerStat(PowerStatEnum value) {
    _selectedPowerStat = value;
    notifyListeners();
  }
}
