import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/text_field_container.dart';

class CompletedInputField extends StatelessWidget {

  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  const CompletedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              fontSize: context.locale == Locale('ru') ? 12 : 14
          ),
        ),
      ),
    );
  }
}

