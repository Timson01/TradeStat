import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/text_field_container.dart';
import 'package:trade_stat/styles/app_colors.dart';

class CompletedPasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const CompletedPasswordField({
    Key? key,
    this.hint = 'Password',
    required this.controller
  }) : super(key: key);

  @override
  State<CompletedPasswordField> createState() => _CompletedPasswordFieldState();
}

class _CompletedPasswordFieldState extends State<CompletedPasswordField> {

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
          controller: widget.controller,
          obscureText: !_passwordVisible,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(
              fontSize: 12,
              color: colorDarkGrey,
              letterSpacing: 1),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            hintText: widget.hint,
            suffixIcon: IconButton(
              iconSize: 18.0,
              icon: Icon(
                _passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: colorGrey,
              ), onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            ),
            hintStyle: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: context.locale == Locale('ru') ? 12 : 14
            ),
          ),
        ));
  }
}


