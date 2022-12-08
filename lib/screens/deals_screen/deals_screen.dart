import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/styles/app_colors.dart';
import 'package:trade_stat/styles/app_images.dart';

import 'components/deals_button_section.dart';
import 'components/deals_container.dart';
import 'components/deals_info_section.dart';
import 'components/deals_top_section.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({Key? key}) : super(key: key);
  static const id = 'deals_screen';

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          DealsTopSection(),
          DealsInfoSection(),
          SizedBox(height: height * 0.03),
          DealsButtonSection(),
          SizedBox(height: height * 0.03),
          DealsContainer()
        ]),
      ),
    ));
  }
}




