import 'package:flutter/material.dart';

import 'exercises_page.dart';
import 'spotlight_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: const [ExercisesPage(), SpotlightPage()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Exercises'),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Spotlight',
          ),
        ],
      ),
    );
  }
}
