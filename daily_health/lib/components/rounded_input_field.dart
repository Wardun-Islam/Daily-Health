import 'package:flutter/material.dart';
import 'package:daily_health/components/text_field_container.dart';
import 'package:daily_health/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String errorText;
  final TextInputType textInputType;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.textInputType,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: textInputType,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
          errorText: errorText,
        ),
      ),
    );
  }
}
