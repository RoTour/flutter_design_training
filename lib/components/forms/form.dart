import 'package:flutter/material.dart';
import 'package:ro_flutter_exercices/components/forms/form_field.dart';

class RoForm extends StatefulWidget {
  const RoForm({Key? key}) : super(key: key);

  @override
  _RoFormState createState() => _RoFormState();
}

class _RoFormState extends State<RoForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RoFormField(icon: Icons.lock, name: 'Password'),
        ],
      ),
    );
  }
}
