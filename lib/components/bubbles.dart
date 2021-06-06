import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

const int nbBubbles = 50;

class Bubbles extends StatefulWidget {
  @override
  _BubblesState createState() => _BubblesState();
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
  List<Bubble> bubbles = [];
  late AnimationController _controller;

  void updateBubblesPosition() {
    List<Bubble> outOfScreenBubbles = [];
    bubbles.forEach((bubble) {
      bubble.updatePosition();
      if (bubble.isOutOfScreen) outOfScreenBubbles.add(bubble);
    });
    outOfScreenBubbles.forEach((element) {
      bubbles.remove(element);
    });
    while (bubbles.length < nbBubbles) {
      bubbles.add(
          Bubble(startFromBeginning: true, gradient: LinearGradient(colors: [Colors.green, Colors.lightGreenAccent])));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: BubblePainter(bubbles: bubbles, controller: _controller),
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
    );
  }

  @override
  void initState() {
    super.initState();
    int x = 0;
    while (x < nbBubbles) {
      bubbles.add(Bubble(gradient: LinearGradient(colors: [Colors.green, Colors.lightGreenAccent])));
      x++;
    }
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1000));
    _controller.addListener(() {
      updateBubblesPosition();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  AnimationController controller;

  BubblePainter({required this.bubbles, required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    bubbles.forEach((it) => it.draw(canvas, size));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  final Gradient gradient;
  late final int radius;
  late int? maxPosX;
  int? posX;
  int? posY;
  int speed = 1;
  bool isOutOfScreen = false;
  bool _startFromBeginning = false;

  Bubble({required this.gradient, bool startFromBeginning = false}) {
    _startFromBeginning = startFromBeginning;
    radius = Random().nextInt(50) + 20;
    speed = Random().nextInt(10) + 1;
    // posX = Random().nextInt(windowSize.width.toInt());
    // posY = Random().nextInt(windowSize.height ~/ 2);
  }

  double spreadBubbles(double value) {
    return (value * value * -1);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    maxPosX = (canvasSize.width * 1.1).toInt();
    if (posX == null) {
      posX = _startFromBeginning
          ? (canvasSize.width * 0.1).toInt() * -1
          : (Random().nextDouble() * canvasSize.width).toInt();
    }
    // if (posY == null) posY = Random().nextInt(canvasSize.height ~/ 2) + canvasSize.height ~/ 2;
    // if (posY == null) posY = (canvasSize.height - (cos(Random().nextDouble() * 2)) * canvasSize.height).toInt();
    if (posY == null) posY = (Random().nextDouble() * canvasSize.height).toInt();
  }

  draw(Canvas canvas, Size size) {
    assignRandomPositionIfUninitialized(size);
    Paint paint = Paint()
      ..shader = gradient
          .createShader(Rect.fromCircle(center: Offset(posX!.toDouble(), posY!.toDouble()), radius: radius.toDouble()))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(posX!.toDouble(), posY!.toDouble()), radius.toDouble(), paint);
  }

  void updatePosition() {
    if (posX != null) {
      posX = posX! + 1 * speed;
      if (maxPosX != null) isOutOfScreen = posX! > maxPosX!;
    }
  }
}
