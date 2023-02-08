import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';
import 'package:trade_stat/screens/welcome_screen/welcome_screen.dart';

import '../generated/locale_keys.g.dart';
import '../screens/verify_email_screen/verify_email_screen.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});
  static const id = 'firebase_stream_screen';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text(LocaleKeys.something_went_wrong.tr())));
        } else if (snapshot.hasData) {
          if (!snapshot.data!.emailVerified) {
            return const VerifyEmailScreen();
          }
          return const DealsScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
