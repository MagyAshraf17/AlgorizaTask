import 'package:flutter/material.dart';

class FiledText extends StatelessWidget {
  final TextEditingController controller;

  final TextInputType inputType;
  final String textLabel;
  final IconData prefix;
  final bool isPassword;
  final String textValidate;
  final Function? onTap;
  final Function? validate;
  const FiledText({
    Key? key,
    required this.textValidate,
    required this.controller,
    required this.inputType,
    required this.textLabel,
    required this.prefix,
    this.isPassword = false,
    this.onTap,
    this.validate,
    //required Icon suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        onTap!();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return textValidate;
        }
        return null;
      },
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: textLabel,
        prefixIcon: Icon(
          prefix,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
