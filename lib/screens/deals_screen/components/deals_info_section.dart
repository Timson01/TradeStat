import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';

import '../../../blocs/bloc_exports.dart';
import '../../../models/deal.dart';
import '../../../styles/style_exports.dart';

enum _PopupMenuValues { onlyPositive, all, onlyNegative }

class DealsInfoSection extends StatelessWidget {
  final List<Deal> dealsList;
  const DealsInfoSection({Key? key, required this.dealsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ValueNotifier<List<int>> dateTime = InheritedDealsScreen.of(context).dateTimeRange;
    DateTimeRange dateTimeRange = DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(dateTime.value[0]),
        end: DateTime.fromMillisecondsSinceEpoch(dateTime.value[1]));

    var income = 0.0;
    List<Deal> deals = dealsList;

    deals.forEach((element) {
      income += element.income;
    });

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.85,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            InkWell(
              onTap: () async {
                DateTimeRange? newDateRange = await showDateRangePicker(
                    context: context,
                    initialDateRange: dateTimeRange,
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2030),
                    builder: (BuildContext? context, Widget? child) {
                      return FittedBox(
                        child: Theme(
                          data: ThemeData(
                            primaryColor: colorBlue,
                          ),
                          child: child!,
                        ),
                      );
                    });

                if (newDateRange != null) {
                  dateTime.value = [newDateRange.start.millisecondsSinceEpoch, newDateRange.end.millisecondsSinceEpoch];
                    context.read<DealsBloc>().add(FetchDealsWithDate(
                        startDate: newDateRange.start.millisecondsSinceEpoch,
                        endDate: newDateRange.end.millisecondsSinceEpoch +
                            86400000));
                }
              },
              child: Text(
                '${DateFormat('yyyy/MM/dd').format(dateTimeRange.start)} - '
                '${DateFormat('yyyy/MM/dd').format(dateTimeRange.end)}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.black),
              ),
            )
          ],
        ),
        SizedBox(height: height * 0.01),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Income: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: income >= 0 ? Colors.green : Colors.red),
                children: [
                  TextSpan(text: '${income.toStringAsFixed(2)} '),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 20,
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          icon: income >= 0
                              ? const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                  size: 20,
                                ),
                          onSelected: (value) {
                            switch (value) {
                              case _PopupMenuValues.onlyPositive:
                                context.read<DealsBloc>().add(
                                    FetchPositiveDeals(
                                        startDate: dateTimeRange
                                            .start.millisecondsSinceEpoch -
                                            86400000,
                                        endDate: dateTimeRange
                                                .end.millisecondsSinceEpoch +
                                            86400000));
                                break;
                              case _PopupMenuValues.all:
                                context.read<DealsBloc>().add(
                                    FetchDealsWithDate(
                                        startDate: dateTimeRange
                                            .start.millisecondsSinceEpoch -
                                            86400000,
                                        endDate: dateTimeRange
                                                .end.millisecondsSinceEpoch +
                                            86400000));
                                break;
                              case _PopupMenuValues.onlyNegative:
                                context.read<DealsBloc>().add(
                                    FetchNegativeDeals(
                                        startDate: dateTimeRange
                                            .start.millisecondsSinceEpoch -
                                            86400000,
                                        endDate: dateTimeRange
                                                .end.millisecondsSinceEpoch +
                                            86400000));
                                break;
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                                  .copyWith(topRight: const Radius.circular(0))),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  padding: const EdgeInsets.only(right: 50, left: 20),
                                  value: _PopupMenuValues.onlyPositive,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_upward,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Only positive deals',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(
                                                    color: Colors.green,
                                                    letterSpacing: 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              PopupMenuItem(
                                  padding: const EdgeInsets.only(
                                      right: 50, left: 20),
                                  value: _PopupMenuValues.all,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.all_inclusive_rounded,
                                            size: 20,
                                            color: colorDarkGrey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'All deals',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(
                                                    color: colorDarkGrey,
                                                    letterSpacing: 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              PopupMenuItem(
                                  padding: const EdgeInsets.only(
                                      right: 50, left: 20),
                                  value: _PopupMenuValues.onlyNegative,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_downward,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Only negative deals',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(
                                                    color: Colors.red,
                                                    letterSpacing: 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ];
                          },
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Count of trades: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${deals.length}',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ]),
    );
  }
}
