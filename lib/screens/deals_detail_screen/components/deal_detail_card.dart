import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trade_stat/screens/deals_detail_screen/deals_detail_screen.dart';

import '../../../models/deal.dart';
import '../../../styles/style_exports.dart';

class DealDetailCard extends StatelessWidget {
  const DealDetailCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Deal currentDeal = InheritedDealsDetailScreen.of(context).currentDeal;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var output = DateFormat('yyyy.MM.dd');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currentDeal.tickerName.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: colorBlue, fontSize: 26),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: currentDeal.income >= 0 ? TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.green),
                  children: [
                    TextSpan(text: '${currentDeal.income} '),
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  ],
                ): TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.red),
                  children: [
                    TextSpan(text: '${currentDeal.income} '),
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                output.format(DateTime.fromMillisecondsSinceEpoch(currentDeal.dateCreated)),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: colorDarkGrey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
