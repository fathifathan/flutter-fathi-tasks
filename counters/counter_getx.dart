import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterGetxController extends GetxController {
  final RxInt count = 0.obs;

  @override
  void onInit() {
    _loadCounter();
    super.onInit();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    count.value = prefs.getInt("counter_getx") ?? 0;
  }

  Future<void> increment() async {
    count.value++;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("counter_getx", count.value);
  }

  Future<void> reset() async {
    count.value = 0;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("counter_getx");
  }
}
