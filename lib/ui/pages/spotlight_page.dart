import 'package:flutter/material.dart';

import '../atoms/loading_spinner.dart';
import '../templates/screen_template.dart';
import '../../models/exercise.dart';
import '../../services/exercise_service.dart';

class SpotlightPage extends StatefulWidget {
  const SpotlightPage({super.key});

  @override
  State<SpotlightPage> createState() => _SpotlightPageState();
}

class _SpotlightPageState extends State<SpotlightPage> {
  late final Stream<Exercise> _stream = exerciseStream(); // created ONCE

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: 'Workout Spotlight',
      body: StreamBuilder<Exercise>(
        stream: _stream,
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(
              child: Text('Failed: ${snap.error}\nRetrying every 5 seconds...'),
            );
          }
          if (!snap.hasData) {
            return const LoadingSpinner();
          }
          final e = snap.data!;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e.name, style: Theme.of(context).textTheme.headlineSmall),
                Text(e.category),
                Text(
                  e.equipment.isEmpty ? 'No equipment' : e.equipment.join(', '),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
