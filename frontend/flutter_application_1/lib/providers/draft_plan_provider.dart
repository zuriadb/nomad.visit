import 'package:flutter/foundation.dart';

class DraftPlanProvider extends ChangeNotifier {
  Map<String, dynamic> _draft = {};

  Map<String, dynamic> get draft => Map.unmodifiable(_draft);

  /// Merge partial data into draft
  void merge(Map<String, dynamic> data) {
    _draft = {..._draft, ...data};
    notifyListeners();
  }

  /// Return draft and clear it (consume)
  Map<String, dynamic> consume() {
    final copy = Map<String, dynamic>.from(_draft);
    _draft.clear();
    notifyListeners();
    return copy;
  }

  void clear() {
    _draft.clear();
    notifyListeners();
  }

  bool get isEmpty => _draft.isEmpty;
}
