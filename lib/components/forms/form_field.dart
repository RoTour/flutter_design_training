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
  String _passwordError = '';

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
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextFormField(
                              cursorColor: Colors.green,
                              onChanged: (newValue) {
                                setState(() {
                                  _password = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                _passwordError = (value == null || value.length < 5)
                                    ? 'Password should be at least 5 characters long'
                                    : '';
                                return null;
                              },
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Text(
                  _passwordError,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
