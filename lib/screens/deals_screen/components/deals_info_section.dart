import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../blocs/bloc_exports.dart';
import '../../../styles/style_exports.dart';

enum _PopupMenuValues { onlyPositive, all, onlyNegative }

class DealsInfoSection extends StatefulWidget {
  const DealsInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  State<DealsInfoSection> createState() => _DealsInfoSectionState();
}

class _DealsInfoSectionState extends State<DealsInfoSection> {
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  bool doItOnce = false;

  @override
  void initState() {
    super.initState();
    context.read<DealsBloc>().add(const FetchDeals());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var income = 0.0;

    return Container(
      width: width * 0.85,
      child: BlocBuilder<DealsBloc, DealsState>(builder: (context, state) {
        income = 0;
        if (state.deals.isNotEmpty) {
          state.deals.forEach((element) {
            income += element.amount;
          });
          if (!doItOnce) {
            dateTimeRange = DateTimeRange(
                start: DateTime.fromMillisecondsSinceEpoch(
                    state.deals[state.deals.length - 1].dateCreated),
                end: DateTime.fromMillisecondsSinceEpoch(
                    state.deals[0].dateCreated));
            doItOnce = !doItOnce;
            print(dateTimeRange);
          }
        }
        return Column(children: [
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
                    setState(() {
                      dateTimeRange = newDateRange;
                      context.read<DealsBloc>().add(FetchDealsWithDate(
                          startDate: newDateRange.start.millisecondsSinceEpoch,
                          endDate: newDateRange.end.millisecondsSinceEpoch + 86400000));
                    });
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
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: income >= 0 ? Colors.green : Colors.red),
                  children: [
                    TextSpan(text: '$income '),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
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
                                          startDate: dateTimeRange.start.millisecondsSinceEpoch,
                                          endDate: dateTimeRange.end.millisecondsSinceEpoch + 86400000)
                                  );
                                  break;
                                case _PopupMenuValues.all:
                                  context.read<DealsBloc>().add(
                                      FetchDealsWithDate(
                                          startDate: dateTimeRange.start.millisecondsSinceEpoch,
                                          endDate: dateTimeRange.end.millisecondsSinceEpoch + 86400000));
                                  break;
                                case _PopupMenuValues.onlyNegative:
                                  context.read<DealsBloc>().add(
                                      FetchNegativeDeals(
                                          startDate: dateTimeRange.start.millisecondsSinceEpoch,
                                          endDate: dateTimeRange.end.millisecondsSinceEpoch + 86400000));
                                  break;
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                                    .copyWith(topRight: Radius.circular(0))),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                    padding:
                                        EdgeInsets.only(right: 50, left: 20),
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
                '${state.deals.length}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ]);
      }),
    );
  }
}
