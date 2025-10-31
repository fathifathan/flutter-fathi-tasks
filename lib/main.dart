import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'pages/todo_page.dart';
import 'pages/provider_page.dart';
import 'pages/getx_page.dart';
import 'providers/name_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NameProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ToDoPage(),
    ProviderPage(),
    GetXPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter State Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.list_alt), label: 'To-Do'),
            NavigationDestination(icon: Icon(Icons.people_alt), label: 'Provider'),
            NavigationDestination(icon: Icon(Icons.bolt), label: 'GetX'),
          ],
        ),
      ),
    );
  }
}
