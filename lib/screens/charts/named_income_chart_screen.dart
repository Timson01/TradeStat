import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/models/charts_model.dart';
import 'package:trade_stat/screens/statistic_screen/statistic_screen.dart';
import 'package:trade_stat/styles/app_colors.dart';
import '../../models/deal.dart';

class NamedIncomeChartScreen extends StatefulWidget {
  final ChartsModel chartModel;

  const NamedIncomeChartScreen({Key? key, required this.chartModel})
      : super(key: key);
  static const id = 'named_income_chart_screen';

  @override
  State<NamedIncomeChartScreen> createState() => _NamedIncomeChartScreenState();
}

class _NamedIncomeChartScreenState extends State<NamedIncomeChartScreen> {
  List<Deal> filteredList = [];
  String title = '';

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                padding: const EdgeInsets.only(left: 20),
                constraints: const BoxConstraints(),
                iconSize: 22,
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.black),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    StatisticScreen.id, (Route<dynamic> route) => false),
              ),
            ),
            BlocBuilder<DealsBloc, DealsState>(
              builder: (context, state) {
                if (state.deals.isNotEmpty) {
                  if (widget.chartModel.name != '') {
                    filteredList = widget.chartModel.hashtag
                        ? state.deals
                            .where((deal) => deal.hashtag
                                .toLowerCase()
                                .contains(widget.chartModel.name.toLowerCase()))
                            .toList()
                        : state.deals
                            .where((deal) => deal.tickerName
                                .toLowerCase()
                                .contains(widget.chartModel.name.toLowerCase()))
                            .toList();
                    title = widget.chartModel.hashtag
                        ? 'Income Chart. Position: ${widget.chartModel.position}.\nHashtag: ${widget.chartModel.name}'
                        : 'Income Chart. Position: ${widget.chartModel.position}.\nTickerSymbol: ${widget.chartModel.name}';
                  } else {
                    filteredList = state.deals;
                    title =
                        'Income Chart. Position: ${widget.chartModel.position}';
                  }
                }
                return Expanded(
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          numberFormat:
                              NumberFormat.simpleCurrency(decimalDigits: 0)),
                      zoomPanBehavior: ZoomPanBehavior(
                          enableDoubleTapZooming: true,
                          enablePanning: true,
                          enablePinching: true,
                          enableSelectionZooming: true),
                      palette: const <Color>[
                        colorBlue,
                      ],
                      title: ChartTitle(
                          text: title,
                          textStyle: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: colorBlue, letterSpacing: 0)),
                      tooltipBehavior: TooltipBehavior(enable: true, header: ''),
                      series: <ChartSeries<Deal, String>>[
                        LineSeries<Deal, String>(
                            name: "Deal",
                            dataSource: filteredList,
                            xValueMapper: (Deal deal, _) =>
                                DateFormat('yyyy/MM/dd')
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        deal.dateCreated))
                                    .toString(),
                            yValueMapper: (Deal deal, _) => deal.income,
                            dataLabelMapper: (Deal deal, _) =>
                                '${deal.tickerName.toUpperCase()}\nIncome: ${deal.income}',
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            markerSettings: const MarkerSettings(isVisible: true),
                            enableTooltip: true)
                      ],
                    ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
