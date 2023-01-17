import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trade_stat/screens/strategy_screen/components/strategy_top_section.dart';

import '../../styles/style_exports.dart';
import 'components/strategy_edit_section.dart';

class StrategyScreen extends StatefulWidget {
  const StrategyScreen({Key? key}) : super(key: key);
  static const id = 'strategy_screen';

  @override
  State<StrategyScreen> createState() => _StrategyScreenState();
}

class _StrategyScreenState extends State<StrategyScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              SvgPicture.asset(addEditDealBackground, fit: BoxFit.cover),
              Positioned(
                top: height * 0.08,
                left: width * 0.075,
                right: width * 0.075,
                bottom: height * 0.05,
                child: WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Column(
                    children: [
                      const StrategyTopSection(),
                      SizedBox(height: height * 0.03),
                      const Spacer(),
                      const StrategyEditSection(),
                      const Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
