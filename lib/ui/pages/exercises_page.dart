import 'package:flutter/material.dart';

import '../../models/exercise.dart';
import '../../services/exercise_service.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  late Future<List<Exercise>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = fetchExercises();
  }

  void _retry() {
    setState(() => _exercisesFuture = fetchExercises());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gym Exercises')),
      body: FutureBuilder<List<Exercise>>(
        future: _exercisesFuture,
        builder: _buildBody,
      ),
    );
  }

  Widget _buildBody(BuildContext ctx, AsyncSnapshot<List<Exercise>> snap) {
    if (snap.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snap.hasError) {
      return Center(
        child: ElevatedButton(
          onPressed: _retry,
          child: Text('Failed: ${snap.error}. Tap to retry'),
        ),
      );
    }
    final exercises = snap.data ?? [];
    if (exercises.isEmpty) {
      return const Center(child: Text('No exercises found'));
    }
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(exercises[i].name),
        subtitle: Text(exercises[i].category),
      ),
    );
  }
}
