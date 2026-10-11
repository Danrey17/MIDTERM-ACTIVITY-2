import 'package:flutter/material.dart';

import '../../models/exercise.dart';
import '../../services/exercise_service.dart';
import '../atoms/loading_spinner.dart';
import '../organisms/exercise_list.dart';
import '../templates/screen_template.dart';

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
    return ScreenTemplate(
      title: 'Gym Exercises',
      body: FutureBuilder<List<Exercise>>(
        future: _exercisesFuture,
        builder: _buildBody,
      ),
    );
  }

  Widget _buildBody(BuildContext ctx, AsyncSnapshot<List<Exercise>> snap) {
    if (snap.connectionState == ConnectionState.waiting) {
      return const LoadingSpinner();
    }
    if (snap.hasError) {
      return Center(
        child: ElevatedButton(
          onPressed: _retry,
          child: Text('Failed: ${snap.error}. Tap to retry'),
        ),
      );
    }
    return ExerciseList(exercises: snap.data ?? []);
  }
}
