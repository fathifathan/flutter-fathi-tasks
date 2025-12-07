import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../counters/counter_provider.dart';

class CounterProviderPage extends StatelessWidget {
  const CounterProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("ChangeNotifier Counter")),
      body: Center(
        child: Text(
          "Counter: ${counter.count}",
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "add",
            onPressed: counter.increment,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "reset",
            backgroundColor: Colors.red,
            onPressed: counter.reset,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
