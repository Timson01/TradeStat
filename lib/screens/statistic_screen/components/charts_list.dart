import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/generated/locale_keys.g.dart';
import 'package:trade_stat/styles/style_exports.dart';

import 'chart_dialog.dart';

class ChartsList extends StatefulWidget {
  const ChartsList({Key? key}) : super(key: key);

  @override
  State<ChartsList> createState() => _ChartsListState();
}

class _ChartsListState extends State<ChartsList> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<String> chartsList = <String>[
      LocaleKeys.income_chart.tr(),
      LocaleKeys.hashtag_income_chart.tr(),
      LocaleKeys.ticker_symbol_income_chart.tr(),
      LocaleKeys.percentage_of_positive_and_negative_deals.tr(),
      LocaleKeys.percentage_of_positive_and_negative_deals_by_hashtag.tr(),
      LocaleKeys.percentage_of_positive_and_negative_deals_by_ticker_symbol.tr(),
    ];

    return SizedBox(
        height: height * 0.8,
        child: Center(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chartsList.length,
            itemBuilder: (_, index) => Column(children: [
              SizedBox(height: index == 0 ? height * 0.01 : 0),
              Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: colorDarkGrey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.6,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        chartsList[index],
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(
                            color: colorDarkGrey,
                          fontSize: context.locale == Locale('ru') ? 14 : 16
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<DealsBloc>().add(const FetchDeals());
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ChartDialog(index: index);
                          },
                        );
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded,
                          color: colorBlue, size: 22),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.04)
            ]),
          ),
        ));
  }
}
