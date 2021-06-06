import 'package:flutter/material.dart';
import 'package:ro_flutter_exercises/components/forms/error_messages.dart';
import 'package:ro_flutter_exercises/components/forms/form_utils.dart';
import 'package:ro_flutter_exercises/components/utils/mutable_string.dart';

class RoFormField extends StatefulWidget {
  final IconData icon;
  final String name;

  /// Should return true is string is valid, else false
  final bool Function(String) validator;
  final String errorMessage;
  final bool hideField;
  final RoFormControl data;

  const RoFormField({
    Key? key,
    required this.icon,
    required this.name,
    required this.data,
    required this.validator,
    required this.errorMessage,
    this.hideField = false,
  }) : super(key: key);

  @override
  _RoFormFieldState createState() => _RoFormFieldState();
}

class _RoFormFieldState extends State<RoFormField> {
  final RoMutableString _fieldErrorState = RoMutableString('');
  late RoAnimatedSlidingText _fieldErrorWidget = RoAnimatedSlidingText(text: _fieldErrorState);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 2,
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8),
                    child: _fieldErrorWidget,
                  ),
                  bottom: 0,
                ),

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
                                obscureText: widget.hideField,
                                cursorColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    widget.data.set(newValue);
                                    if (widget.validator(newValue)) {
                                      _fieldErrorWidget.hide();
                                      return;
                                    }
                                    _fieldErrorState.setStr(widget.errorMessage);
                                    _fieldErrorWidget.show();
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
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
