import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/screens/welcome_screen/welcome_screen.dart';
import 'package:trade_stat/styles/my_images.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({Key? key}) : super(key: key);
  static const id = 'description_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: height * 0.05),
          SvgPicture.asset(desc_image, width: width, fit: BoxFit.scaleDown),
          SizedBox(height: height * 0.05),
          const Text(
            'TradeStat',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              letterSpacing: 4,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: height * 0.05),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(bottom_background,
                      width: width, fit: BoxFit.cover),
                ),
                Positioned(
                  left: width * 0.08,
                  right: width * 0.08,
                  child: const Text(
                    'Keep statistics, improve your strategy correctly and increase your income with TradeStat',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: height * 0.05,
                  left: width * 0.08,
                  right: width * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Let’s started',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed(WelcomeScreen.id),
                        child: SvgPicture.asset(
                          next_single_arrow,
                          width: 28,
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
