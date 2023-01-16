import 'package:flutter/material.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';
import 'package:trade_stat/screens/registration_screen/registration_screen.dart';

import '../../styles/app_colors.dart';
import '../log_in_screen/log_in_screen.dart';

class LogInRegisterBottomSection extends StatelessWidget {

  String id;

  LogInRegisterBottomSection({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              id == LogInScreen.id ?
              'Log In' : 'Create',
              style: Theme.of(context).textTheme.headlineMedium,

            ),
            Container(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: colorBlue,
                onPressed: () => Navigator.of(context).pushNamed(DealsScreen.id),
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
              id == LogInScreen.id ?
              'Don’t have an account?' : 'Already have an account?',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: colorDarkGrey
              ),
            ),
            SizedBox(width: 5),
            InkWell(
              child: Text(
                id == LogInScreen.id ?
                'Sign Up' : 'Log In',
                style: TextStyle(
                  color: colorMidnightBlue,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
              onTap: () =>
              id == LogInScreen.id ?
              Navigator.of(context).pushReplacementNamed(RegistrationScreen.id)
              : Navigator.of(context).pushReplacementNamed(LogInScreen.id),
            ),
          ],
        )
      ],
    );
  }
}