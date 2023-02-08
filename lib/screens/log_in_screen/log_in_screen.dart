
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/completed_input_field.dart';
import 'package:trade_stat/screens/components/completed_password_field.dart';
import 'package:trade_stat/screens/reset_password_screen/reset_password_screen.dart';
import 'package:trade_stat/styles/app_colors.dart';
import '../../generated/locale_keys.g.dart';
import '../components/log_in_register_bottom_section.dart';
import '../components/log_in_register_top_background.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);
  static const id = 'log_in_screen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogInRegisterTopBackground(id: LogInScreen.id),
              SizedBox(height: height * 0.08),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Column(
                  children: [
                    CompletedInputField(hintText: LocaleKeys.log_in_register_eMail.tr(), controller: eMailController),
                    CompletedPasswordField(hint: LocaleKeys.log_in_register_password.tr(), controller: passwordController),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pushNamed(ResetPasswordScreen.id),
                            child: Text(
                              LocaleKeys.log_in_forgot.tr(),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: colorDarkGrey
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.08),
                    LogInRegisterBottomSection(id: LogInScreen.id, eMailController: eMailController, passwordController: passwordController),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

