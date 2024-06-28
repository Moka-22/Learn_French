import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.controller,
    this.textInputType,
    this.initialValue,
    this.readOnly = false,
  });
  final String? hintText;
  final String? labelText;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? obscureText;
  final String? initialValue;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      initialValue: initialValue,
      keyboardType: textInputType,
      controller: controller,
      validator: validator,
      obscureText: obscureText!,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: primaryColor,
        suffixIconColor: primaryColor,
        hintText: hintText,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
