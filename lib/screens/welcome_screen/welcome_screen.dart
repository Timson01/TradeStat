import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/styles/style_exports.dart';
import 'components/welcome_screen_bottom_section.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: height * 0.05),
          const Text(
            'Welcome',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              letterSpacing: 4,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: height * 0.07),
          SvgPicture.asset(welcomeImage, width: width, fit: BoxFit.scaleDown),
          SizedBox(height: height * 0.07),
          const Expanded(
            child: WelcomeScreenBottom(),
          ),
        ],
      ),
    ));
  }
}