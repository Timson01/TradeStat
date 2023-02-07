import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/registration_screen/registration_screen.dart';
import 'package:trade_stat/services/firebase_auth_methods.dart';

import '../../generated/locale_keys.g.dart';
import '../../styles/app_colors.dart';
import '../log_in_screen/log_in_screen.dart';

class LogInRegisterBottomSection extends StatefulWidget {

  String id;
  final TextEditingController eMailController;
  final TextEditingController passwordController;

  LogInRegisterBottomSection({
    Key? key,
    required this.id,
    required this.eMailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<LogInRegisterBottomSection> createState() => _LogInRegisterBottomSectionState();
}

class _LogInRegisterBottomSectionState extends State<LogInRegisterBottomSection> {

  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: widget.eMailController.text,
        password: widget.passwordController.text,
        context: context
    );
  }

  void logInUser(){
    FirebaseAuthMethods(FirebaseAuth.instance).logInWithEmail(
        email: widget.eMailController.text,
        password: widget.passwordController.text,
        context: context
    );
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.id == LogInScreen.id ?
              LocaleKeys.log_in.tr() : LocaleKeys.create.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  letterSpacing: context.locale == Locale('ru') ? 1 : 4,
                  fontSize: context.locale == Locale('ru') ? 30 : 32
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: colorBlue,
                onPressed: widget.id == RegistrationScreen.id ? signUpUser : logInUser,
                child: const Icon(
                    size: 18,
                    color: Colors.white,
                    Icons.arrow_forward_ios
                ),
              ),
            )
          ],
        ),
        SizedBox(height: height*0.06),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.id == LogInScreen.id ?
              LocaleKeys.log_in_sign_up_desc.tr() : LocaleKeys.log_in_button_desc.tr(),
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: colorDarkGrey,
                  letterSpacing: context.locale == Locale('ru') ? 0 : 2,
              ),
            ),
            SizedBox(width: 5),
            InkWell(
              child: Text(
                widget.id == LogInScreen.id ?
                LocaleKeys.sign_up.tr() : LocaleKeys.log_in.tr(),
                style: TextStyle(
                  color: colorMidnightBlue,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: context.locale == Locale('ru') ? 0 : 2
                ),
              ),
              onTap: () =>
              widget.id == LogInScreen.id ?
              Navigator.of(context).pushReplacementNamed(RegistrationScreen.id)
              : Navigator.of(context).pushReplacementNamed(LogInScreen.id),
            ),
          ],
        ),
        SizedBox(height: height*0.06),
      ],
    );
  }
}