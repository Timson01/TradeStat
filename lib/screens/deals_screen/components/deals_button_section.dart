import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/add_deal_screen.dart';
import 'package:trade_stat/screens/rules_screen/rules_screen.dart';
import 'package:trade_stat/screens/strategy_screen/strategy_screen.dart';

import '../../../styles/style_exports.dart';

class DealsButtonSection extends StatefulWidget {
  const DealsButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  State<DealsButtonSection> createState() => _DealsButtonSectionState();
}

class _DealsButtonSectionState extends State<DealsButtonSection> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.01),
      width: width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: SvgPicture.asset(rulesIcon, width: 20, fit: BoxFit.cover),
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pushNamed(RulesScreen.id);
            }
          ),
          InkWell(
            child: SvgPicture.asset(addDealIcon, width: 20, fit: BoxFit.cover),
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pushNamed(AddDealScreen.id);
            },
          ),
          InkWell(
            child: SvgPicture.asset(strategyIcon, width: 20, fit: BoxFit.cover),
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).pushReplacementNamed(StrategyScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
