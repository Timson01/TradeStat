import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/generated/locale_keys.g.dart';
import 'package:trade_stat/screens/welcome_screen/welcome_screen.dart';
import 'package:trade_stat/styles/style_exports.dart';

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
          SvgPicture.asset(descImage, width: width, fit: BoxFit.scaleDown),
          SizedBox(height: height * 0.05),
          Text(
            'TradeStat',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: height * 0.05),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(bottomBackground,
                      width: width, fit: BoxFit.cover),
                ),
                Positioned(
                  left: width * 0.08,
                  right: width * 0.08,
                  child: Text(
                    LocaleKeys.desc_description.tr(),
                    style: Theme.of(context).textTheme.subtitle1,
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
                      Text(
                        LocaleKeys.desc_button_title.tr(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed(WelcomeScreen.id),
                        child: SvgPicture.asset(
                          nextSingleArrowIcon,
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
