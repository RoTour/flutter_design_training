import 'package:flutter/material.dart';

class RoFormField extends StatefulWidget {
  final IconData icon;
  final String name;

  const RoFormField({Key? key, required this.icon, required this.name}) : super(key: key);

  @override
  _RoFormFieldState createState() => _RoFormFieldState();
}

class _RoFormFieldState extends State<RoFormField> {
  String _password = '';
  final RoMutableString _passwordError = RoMutableString('');
  late RoAnimatedSlidingText _passwordErrorWidget = RoAnimatedSlidingText(text: _passwordError);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// FormField
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.green, Colors.lightGreenAccent]),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(32), right: Radius.circular(32)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(widget.icon, color: Colors.white),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.horizontal(left: Radius.circular(32), right: Radius.circular(32)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: TextFormField(
                              cursorColor: Colors.green,
                              onChanged: (newValue) {
                                setState(() {
                                  _password = newValue;
                                  if (newValue.length < 5) {
                                    _passwordError.setStr('Password should be at least 5 characters long');
                                    _passwordErrorWidget.show();
                                  } else {
                                    _passwordErrorWidget.hide();
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: widget.name,
                                  labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto),
                              autocorrect: false,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// ErrorMSG
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: _passwordErrorWidget,
              )
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}

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
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    widget._offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
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
    print('Text in widget = ${widget.text.str}');
    return SlideTransition(
      position: widget._offsetAnimation,
      child: Text(
        widget.text.str,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class RoMutableString {
  String _str;
  List<Function> subscribers = [];

  RoMutableString(this._str);

  get str {
    return _str;
  }

  void setStr(String newStr) {
    this._str = newStr;
    subscribers.forEach((fn) {
      fn();
    });
  }
}
