import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/screens/charts/income_chart_screen.dart';

import '../../../styles/style_exports.dart';

class ChartDialog extends StatefulWidget {
  final int index;

  const ChartDialog({Key? key, required this.index}) : super(key: key);

  @override
  State<ChartDialog> createState() => _ChartDialogState();
}

class _ChartDialogState extends State<ChartDialog> {
  bool haveSearch = false;
  bool hashtag = false;
  bool doItOnce = false;
  var currentSelectedValuePosition = 'Long';
  List<String> position = <String>['Long', 'All', 'Short'];
  String id = '';
  String title = '';
  final _controller = TextEditingController();
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  void initState() {
    context.read<DealsBloc>().add(const FetchDeals());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    switch (widget.index) {
      case 0:
        id = IncomeChartScreen.id;
        title = 'Income chart';
        break;
      case 1:
        hashtag = true;
        haveSearch = true;
        title = 'Hashtag income chart';
        break;
      case 2:
        haveSearch = true;
        title = 'Ticker symbol income chart';
        break;
      case 3:
        title = 'Percentage of positive and negative deals';
        break;
      case 4:
        hashtag = true;
        haveSearch = true;
        title = 'Percentage of positive and negative deals by hashtag';
        break;
      case 5:
        haveSearch = true;
        title = 'Percentage of positive and negative deals by ticker symbol';
        break;
      case 6:
        title = 'Percentage of positive and negative deals by all hashtags';
        break;
      case 7:
        title = 'Percentage of positive and negative deals by all ticker symbols';
        break;
    }

    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5?.copyWith(
              letterSpacing: 0,
              fontSize: 18,
            ),
      ),
      content: SizedBox(
        height: height * 0.3,
        width: width * 0.8,
        child: Column(
            mainAxisAlignment: haveSearch ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceEvenly,
            children: [

              // ------------ Search Section -----------

              haveSearch
                  ? Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      Text(
                        hashtag ? 'Hashtag:' : 'Ticker symbol:',
                        style: Theme.of(context).textTheme.subtitle2
                            ?.copyWith(
                            fontSize: 15,
                            color: colorDarkGrey,
                            letterSpacing: 1),
                      ),
                      SizedBox(height: height * 0.015),
                      TextField(
                          controller: _controller,
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 12, color: colorDarkGrey, letterSpacing: 1),
                          decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: colorDarkGrey)),
                              hintText:
                                  hashtag ? 'Enter hashtag' : 'Enter ticker symbol',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      fontSize: 12,
                                      color: colorDarkGrey,
                                      letterSpacing: 1)),
                        ),
                      SizedBox(height: height * 0.02),
                    ],
                  )
                  : const SizedBox(height: 1),

              // ------------ Date Section -----------

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date: ',
                    style: Theme.of(context).textTheme.subtitle2
                        ?.copyWith(
                        fontSize: 15,
                        color: colorDarkGrey,
                        letterSpacing: 1),
                  ),
                  SizedBox(height: height * 0.015),
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
                              startDate:
                                  newDateRange.start.millisecondsSinceEpoch,
                              endDate: newDateRange.end.millisecondsSinceEpoch +
                                  86400000));
                        });
                      }
                    },
                    child: Text(
                      '${DateFormat('yyyy/MM/dd').format(dateTimeRange.start)} - '
                      '${DateFormat('yyyy/MM/dd').format(dateTimeRange.end)}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(
                          fontSize: 14,
                          color: colorMidnightBlue,
                          letterSpacing: 1),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.02),

              // ------------ Position Section -----------

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Position: ',
                    style: Theme.of(context).textTheme.subtitle2
                        ?.copyWith(
                        fontSize: 15,
                        color: colorDarkGrey,
                        letterSpacing: 1),
                  ),
                  SizedBox(height: height * 0.015),
                  Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      isDense: true,
                      value: currentSelectedValuePosition,
                      items: position
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                                fontSize: 14,
                                                color: colorMidnightBlue,
                                                letterSpacing: 1)),
                                  ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          currentSelectedValuePosition = newValue!;
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
      ),

      // ------------ Buttons Section -----------

      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorMidnightBlue, letterSpacing: 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Confirm',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorMidnightBlue, letterSpacing: 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }
}
