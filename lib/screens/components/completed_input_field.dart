import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/text_field_container.dart';

import '../../styles/app_colors.dart';

class CompletedInputField extends StatelessWidget {

  final String? hintText;
  final IconData icon;
  final TextEditingController controller;

  const CompletedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            ?.copyWith(
            fontSize: 12,
            color: colorDarkGrey,
            letterSpacing: 1),
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

