import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../models/exercise.dart';

Future<List<Exercise>> fetchExercises() async {
  final uri = Uri.parse(
    'https://wger.de/api/v2/exerciseinfo/?language=2&limit=20&format=json',
  );
  final res = await http.get(uri).timeout(const Duration(seconds: 10));
  if (res.statusCode != 200) {
    throw Exception('Server said ${res.statusCode}');
  }
  final body = jsonDecode(res.body) as Map<String, dynamic>;
  final results = body['results'] as List<dynamic>;
  return results
      .map((j) => Exercise.fromJson(j as Map<String, dynamic>))
      .toList();
}

final _rng = Random();

Future<Exercise> fetchRandomExercise() async {
  final offset = _rng.nextInt(900);
  final uri = Uri.parse(
    'https://wger.de/api/v2/exerciseinfo/?limit=1&offset=$offset&format=json',
  );
  final res = await http.get(uri).timeout(const Duration(seconds: 10));
  if (res.statusCode != 200) {
    throw Exception('Server said ${res.statusCode}');
  }
  final body = jsonDecode(res.body) as Map<String, dynamic>;
  final results = body['results'] as List<dynamic>;
  return Exercise.fromJson(results.first as Map<String, dynamic>);
}

Stream<Exercise> exerciseStream() =>
    Stream.periodic(const Duration(seconds: 5))
        .asyncMap((_) => fetchRandomExercise());
