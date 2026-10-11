import 'package:flutter/material.dart';

import '../../models/exercise.dart';
import '../molecules/exercise_tile.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;
  const ExerciseList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return const Center(child: Text('No exercises found'));
    }
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (_, i) => ExerciseTile(exercise: exercises[i]),
    );
  }
}
