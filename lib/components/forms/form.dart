import 'package:flutter/material.dart';
import 'package:ro_flutter_exercises/components/forms/form_field.dart';
import 'package:ro_flutter_exercises/components/forms/form_utils.dart';

class RoForm extends StatefulWidget {
  const RoForm({Key? key}) : super(key: key);

  @override
  _RoFormState createState() => _RoFormState();
}

const String usernameKey = 'username';
const String passwordKey = 'password';

class _RoFormState extends State<RoForm> {
  final _formKey = GlobalKey<FormState>();

  final RoFormController _formController = RoFormController({
    usernameKey: '',
    passwordKey: '',
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RoFormField(
              icon: Icons.person,
              name: 'Username',
              data: _formController.dataOf(usernameKey),
              validator: (value) => value.length >= 3,
              errorMessage: 'Username should be at least 3 characters long',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RoFormField(
              icon: Icons.lock,
              name: 'Password',
              data: _formController.dataOf(passwordKey),
              validator: (value) => value.length >= 5,
              errorMessage: 'Password should be at least 5 characters long',
              hideField: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                print(_formController.fields);
              },
              child: Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }
}
