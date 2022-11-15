
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/completed_input_field.dart';
import 'package:trade_stat/screens/components/completed_password_field.dart';
import 'package:trade_stat/styles/app_colors.dart';
import '../components/log_in_register_bottom_section.dart';
import '../components/log_in_register_top_background.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);
  static const id = 'log_in_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LogInRegisterTopBackground(id: id),
            SizedBox(height: height * 0.08),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Column(
                children: [
                  CompletedInputField(hintText: 'eMail'),
                  CompletedPasswordField(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            'Forgot your password?',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: colorDarkGrey
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.08),
                  LogInRegisterBottomSection(),
                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}

