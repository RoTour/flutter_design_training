import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class AnimatedLink extends StatefulWidget {
  @override
  _AnimatedLinkState createState() => _AnimatedLinkState();
}

class _AnimatedLinkState extends State<AnimatedLink> {
  bool _hovered = false;
  Text buttonText = Text('Animated Button', style: TextStyle(fontSize: 24));
  double textButtonWidth = 0;
  var key = RectGetter.createGlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Curves.easeOut,
        child: Center(
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {},
            onHover: (hovering) {
              // print(hovering);
              setState(() {
                _hovered = hovering;
                print('Height is ${context.size?.width}');
                print('Rect is ${RectGetter.getRectFromKey(key)?.width}');
                textButtonWidth = RectGetter.getRectFromKey(key)?.width ?? 0;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectGetter(key: key, child: Text('Animated Button', style: TextStyle(fontSize: 24))),
                AnimatedContainer(
                  color: Colors.red,
                  height: 5,
                  width: _hovered ? textButtonWidth : 0,
                  duration: Duration(seconds: 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var animatedButtonDecoration = Container(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text('Animated Button'),
  ),
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFFF0000),
        width: 3,
        // style: _hovered ? BorderStyle.solid : BorderStyle.none,
      ),
    ),
  ),
);
