import 'package:flutter/material.dart';
import 'package:ro_flutter_exercises/components/utils/mutable_string.dart';

class RoAnimatedSlidingText extends StatefulWidget {
  final RoMutableString text;
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  RoAnimatedSlidingText({required this.text});

  @override
  State<RoAnimatedSlidingText> createState() => _RoAnimatedSlidingTextState();

  void show() {
    _controller.forward(from: _controller.value);
  }

  void hide() {
    _controller.reverse(from: _controller.value).then((value) => text.setStr(''));
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _RoAnimatedSlidingTextState extends State<RoAnimatedSlidingText> with SingleTickerProviderStateMixin {
  late Function sub = () {
    setState(() {});
  };

  @override
  void initState() {
    super.initState();
    widget._controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    widget._offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -3),
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: widget._controller,
      curve: Curves.fastOutSlowIn,
    ))
      ..addListener(() {
        setState(() {});
      });

    widget.text.subscribers.add(sub);
  }

  @override
  void dispose() {
    super.dispose();
    widget._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget._offsetAnimation,
      child: Text(
        widget.text.str,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
      ),
    );
  }
}
