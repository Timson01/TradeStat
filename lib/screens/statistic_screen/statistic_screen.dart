import 'package:flutter/material.dart';
import 'package:trade_stat/screens/statistic_screen/components/charts_list.dart';
import 'components/statistic_top_section.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({Key? key}) : super(key: key);
  static const id = 'statistic_screen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const StatisticTopSection(),
                    const ChartsList(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
