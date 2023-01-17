import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/completed_input_field.dart';
import 'package:trade_stat/screens/components/completed_password_field.dart';
import '../components/log_in_register_bottom_section.dart';
import '../components/log_in_register_top_background.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const id = 'registration_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogInRegisterTopBackground(id: id),
              SizedBox(height: height * 0.06),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    children: [
                      CompletedInputField(hintText: 'Name'),
                      CompletedInputField(hintText: 'eMail'),
                      CompletedPasswordField(),
                      SizedBox(height: height * 0.07),
                      LogInRegisterBottomSection(id: id),
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
