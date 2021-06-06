import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class AnimatedLink extends StatefulWidget {
  @override
  _AnimatedLinkState createState() => _AnimatedLinkState();
}

class _AnimatedLinkState extends State<AnimatedLink> with TickerProviderStateMixin {
  bool _hovered = false;
  Text buttonText = Text('Animated Button', style: TextStyle(fontSize: 24));
  double textButtonWidth = 0;
  var key = RectGetter.createGlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {},
      onHover: (hovering) {
        setState(() {
          _hovered = hovering;
          textButtonWidth = RectGetter.getRectFromKey(key)?.width ?? 0;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            child: RectGetter(
              key: key,
              child: Text(
                'Animated Button',
                style: TextStyle(fontSize: 24, fontWeight: _hovered ? FontWeight.w900 : FontWeight.w400),
              ),
            ),
          ),
          AnimatedContainer(
            color: Colors.red,
            height: 5,
            width: _hovered ? textButtonWidth : 0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        ],
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
