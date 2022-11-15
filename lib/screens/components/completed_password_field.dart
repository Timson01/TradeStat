import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/text_field_container.dart';
import 'package:trade_stat/styles/app_colors.dart';

class CompletedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String hint;

  const CompletedPasswordField({
    Key? key,
    this.hint = 'Password',
    this.onChanged,
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
          obscureText: !_passwordVisible,
          onChanged: widget.onChanged,
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
            hintStyle: const TextStyle(
                fontFamily: 'Lato', fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ));
  }
}


