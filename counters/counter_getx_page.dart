import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../counters/counter_getx.dart';

class CounterGetxPage extends StatelessWidget {
  CounterGetxPage({super.key});

  final controller = Get.put(CounterGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX Counter")),
      body: Center(
        child: Obx(() => Text(
              "Counter: ${controller.count}",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            )),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "add",
            onPressed: controller.increment,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "reset",
            backgroundColor: Colors.red,
            onPressed: controller.reset,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
