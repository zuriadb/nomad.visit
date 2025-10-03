import 'package:flutter/foundation.dart';

class PlanProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _plans = [];

  List<Map<String, dynamic>> get plans => List.unmodifiable(_plans);

  void addPlan(Map<String, dynamic> plan) {
    _plans.add(plan);
    notifyListeners();
  }

  void deletePlan(int index) {
    if (index >= 0 && index < _plans.length) {
      _plans.removeAt(index);
      notifyListeners();
    }
  }

  void clear() {
    _plans.clear();
    notifyListeners();
  }

  bool get hasPlans => _plans.isNotEmpty;
}
