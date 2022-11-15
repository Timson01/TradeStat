import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/screens/log_in_screen/log_in_screen.dart';
import 'package:trade_stat/screens/welcome_screen/components/welcome_screen_button.dart';
import 'package:trade_stat/styles/style_exports.dart';

class WelcomeScreenBottom extends StatelessWidget {
  const WelcomeScreenBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(bottomBackground,
              width: width, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: height * 0.05,
          left: width * 0.08,
          right: width * 0.08,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: const WelcomeScreenButton(title: 'Sign Up'),
              ),
              SizedBox(height: height * 0.02),
              Text(
                  'or',
                style: Theme.of(context).textTheme.subtitle1
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () {},
                child: const WelcomeScreenButton(
                    title: 'Sign in with Google'),
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?',
                      style: TextStyle(
                        color: colorGrey,
                        fontSize: 14,
                        fontFamily: 'Lato',
                        letterSpacing: 3,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(LogInScreen.id),
                    child: Text(' Log In',
                        style: Theme.of(context).textTheme.subtitle2
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
