import 'package:flutter/material.dart';
import 'package:ro_flutter_exercices/exercises/bubbles.dart';

void main() {
  runApp(ExercisesApp());
}

class ExercisesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/bubbles': (context) => Bubbles()},
      initialRoute: '/bubbles',
    );
  }
}
