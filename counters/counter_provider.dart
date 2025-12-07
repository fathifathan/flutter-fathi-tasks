import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  CounterProvider() {
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _count = prefs.getInt("counter_provider") ?? 0;
    notifyListeners();
  }

  Future<void> increment() async {
    _count++;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("counter_provider", _count);
  }

  Future<void> reset() async {
    _count = 0;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove("counter_provider");
  }
}
