import 'package:flutter/material.dart';
import 'package:trade_stat/styles/style_exports.dart';

class ChartsList extends StatelessWidget {
  const ChartsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<String> chartsList = <String>[
      'Percentage of positive and negative trades',
      'Percentage of positive and negative deals by hashtag',
      'Percentage of positive and negative deals by ticker symbol',
      'Period yield chart',
      'All time yield chart',
      'Hashtag yield chart',
      'Ticker symbol yield chart',
      'Hashtag yield chart for the period',
      'Ticker symbol yield chart for the period',
      'Trading statistics schedule',
      'Short trade income chart',
      'Long trade income chart',
      'Percentage of positive and negative trades in Short',
      'Percentage of positive and negative trades in Long',
      'Percentage of positive and negative trades in Short by hashtag',
      'Percentage of positive and negative trades in Short by ticker symbol',
      'Percentage of positive and negative trades in Long by hashtag',
      'Percentage of positive and negative trades in Long by ticker symbol',
    ];

    return SizedBox(
        height: height * 0.8,
        child: ListView.builder(
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
                    color: colorMidnightBlue.withOpacity(0.2),
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
                          ?.copyWith(color: colorDarkGrey),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_rounded,
                        color: colorBlue),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.03)
          ]),
        ));
  }
}
