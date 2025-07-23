import 'package:flutter/material.dart';
import 'package:flutter_application_6/static_classes/user_informations.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: Colors.blueAccent, fontSize: 25),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: Icon(
            isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
      cursorColor: Colors.blue,
      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        }
        if (value.length < 8) {
          return 'Password is too short';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null) {
          UserInformations.password = value; // تأكد من عدم كون القيمة null
        }
      },
    );
  }
}
