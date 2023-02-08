import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/welcome_screen/welcome_screen.dart';
import '../../generated/locale_keys.g.dart';
import '../../styles/app_colors.dart';
import '../../utils/show_snack_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const id = 'reset_password_screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailTextInputController = TextEditingController();

  @override
  void dispose() {
    emailTextInputController.dispose();

    super.dispose();
  }

  Future<void> resetPassword() async {
    final navigator = Navigator.of(context);
    final scaffoldMassager = ScaffoldMessenger.of(context);

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailTextInputController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found') {
        SnackBarService.showSnackBar(
          context,
          LocaleKeys.email_not_found.tr(),
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          LocaleKeys.unknown_error.tr(),
          true,
        );
        return;
      }
    }

    var snackBar = SnackBar(
      content: Text(LocaleKeys.reset_password_done.tr()),
      backgroundColor: Colors.green,
    );

    scaffoldMassager.showSnackBar(snackBar);

    navigator.pushNamedAndRemoveUntil(WelcomeScreen.id, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(LocaleKeys.reset_password_title.tr(),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(
                    fontSize: 12,
                    color: colorDarkGrey,
                    letterSpacing: 1),
                controller: emailTextInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: LocaleKeys.enter_email.tr(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorBlue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                        letterSpacing: 1)),
                child: Center(child: Text(LocaleKeys.reset_password.tr())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}