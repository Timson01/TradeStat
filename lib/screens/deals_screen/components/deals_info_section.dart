import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../blocs/bloc_exports.dart';
import '../../../styles/style_exports.dart';

class DealsInfoSection extends StatefulWidget {
  const DealsInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  State<DealsInfoSection> createState() => _DealsInfoSectionState();
}

class _DealsInfoSectionState extends State<DealsInfoSection> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var income = 0.0;

    Future _pickDateRange({required int startDate, required int endDate}) async {
      DateTimeRange? newDateRange = await showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
              start: DateTime.fromMillisecondsSinceEpoch(startDate),
              end: DateTime.fromMillisecondsSinceEpoch(endDate)
          ),
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

      if (newDateRange == null) return;
      setState(() {
        // Put here realization
      });
    }

    return BlocBuilder<DealsBloc, DealsState>(
      builder: (context, state) {
        state.deals.forEach((element) {
          income += element.amount;
        });
        return Container(
          width: width * 0.85,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                state.deals.isNotEmpty ?
                InkWell(
                  onTap: () => _pickDateRange(startDate: state.deals[0].dateCreated, endDate: state.deals[state.deals.length - 1].dateCreated),
                  child: Text(
                    '${DateFormat('dd.MM.yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(state.deals[0].dateCreated))} - '
                        '${DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(state.deals[state.deals.length - 1].dateCreated))}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black),
                  ),
                ) :
                InkWell(
                  onTap: () => _pickDateRange(startDate: DateTime.now().millisecondsSinceEpoch, endDate: DateTime.now().millisecondsSinceEpoch),
                  child: Text(
                    state.deals.isNotEmpty ?
                    '${DateFormat('dd.MM.yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(state.deals[0].dateCreated))} - '
                        '${DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(state.deals[state.deals.length - 1].dateCreated))}':
                    '${DateFormat('dd.MM.yyyy').format(
                        DateTime.now())} - '
                        '${DateFormat('dd.MM.yyyy').format( DateTime.now())}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black),
                  ),
                ),
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
                        child: income >= 0
                            ? Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                                size: 20,
                              )
                            : Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                                size: 20,
                              ),
                      ),
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
          ]),
        );
      },
    );
  }
}
