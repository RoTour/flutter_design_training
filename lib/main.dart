import 'package:flutter/material.dart';
import 'package:ro_flutter_exercises/components/bubbles.dart';
import 'package:ro_flutter_exercises/components/forms/form.dart';
import 'package:ro_flutter_exercises/components/ro_animated_link_1.dart';

void main() {
  runApp(ExercisesApp());
}

class ExercisesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/bubbles': (context) => Bubbles(),
        '/animated-link': (context) => ComponentContainer(child: AnimatedLink()),
        '/form': (context) => ComponentContainer(child: RoForm())
      },
      initialRoute: '/form',
    );
  }
}

class ComponentContainer extends StatelessWidget {
  final Widget child;

  ComponentContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: child,
      ),
    );
  }
}
