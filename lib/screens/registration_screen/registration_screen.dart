import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/components/completed_input_field.dart';
import 'package:trade_stat/screens/components/completed_password_field.dart';
import '../../generated/locale_keys.g.dart';
import '../../utils/show_snack_bar.dart';
import '../components/log_in_register_bottom_section.dart';
import '../components/log_in_register_top_background.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);
  static const id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    eMailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogInRegisterTopBackground(id: RegistrationScreen.id),
              SizedBox(height: height * 0.06),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    children: [
                      CompletedInputField(hintText: LocaleKeys.log_in_register_eMail.tr(), controller: eMailController),
                      CompletedPasswordField(controller: passwordController),
                      SizedBox(height: height * 0.07),
                      LogInRegisterBottomSection(id: RegistrationScreen.id, eMailController: eMailController, passwordController: passwordController),
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
