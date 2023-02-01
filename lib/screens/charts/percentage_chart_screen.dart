import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../blocs/bloc_exports.dart';
import '../../models/charts_model.dart';
import '../../models/deal.dart';
import '../../styles/style_exports.dart';
import '../statistic_screen/statistic_screen.dart';

class PercentageChartScreen extends StatefulWidget {
  final ChartsModel chartModel;
  const PercentageChartScreen({
    Key? key,
    required this.chartModel
  }) : super(key: key);

  static const id = 'percentage_chart_screen';

  @override
  State<PercentageChartScreen> createState() => _PercentageChartScreenState();
}

class _PercentageChartScreenState extends State<PercentageChartScreen> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    String startDate = DateFormat('yyyy/MM/dd').format(widget.chartModel.dateTimeRange.start);
    String endDate = DateFormat('yyyy/MM/dd').format(widget.chartModel.dateTimeRange.end);

    List<Deal> filteredList = [];
    List<CircularChartData> chartData = [];
    String title = '';
    int positiveCount = 0;
    double positive = 0;
    double negative = 0;

    void init(List<Deal> deals, String startDate, String endDate){
      if(widget.chartModel.name != ''){
        filteredList = widget.chartModel.hashtag ? deals.where((deal) =>  deal.hashtag
            .toLowerCase()
            .contains(widget.chartModel.name.toLowerCase()))
            .toList() :
        deals.where((deal) =>  deal.tickerName
            .toLowerCase()
            .contains(widget.chartModel.name.toLowerCase()))
            .toList();
        title = widget.chartModel.hashtag ?
        'Percentage of positive and negative deals.\nDate: $startDate - $endDate'
            '\nPosition: ${widget.chartModel.position}. Hashtag: ${widget.chartModel.name}'
            : 'Percentage of positive and negative deals.\nDate: $startDate - $endDate'
            '\nPosition: ${widget.chartModel.position}. '
            'TickerSymbol: ${widget.chartModel.name}';
      }else{
        filteredList = deals;
        title = 'Percentage of positive and negative deals.'
            '\nDate: $startDate - $endDate'
            '\n Position: ${widget.chartModel.position}';
      }
      if(filteredList.isNotEmpty){
        for (var element in filteredList) {
          if(element.income >= 0){
            positiveCount++;
          }
        }
        positive = positiveCount / filteredList.length * 100;
        negative = 100 - positive;
        chartData = [CircularChartData(name: 'Positive', percent: double.parse(positive.toStringAsFixed(2))),
          CircularChartData(name: 'Negative', percent: double.parse(negative.toStringAsFixed(2))),];
      }
    }

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
                    if(state.deals.isNotEmpty) {
                      init(state.deals, startDate, endDate);
                    }
                    return Expanded(
                        child: state.deals.isNotEmpty ? SfCircularChart(
                          palette: const <Color>[
                            colorBlue,
                            Colors.red
                          ],
                          title: ChartTitle(text: title,
                              textStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                                  color: colorBlue,
                                  letterSpacing: 0
                              )),
                          tooltipBehavior: TooltipBehavior(
                              enable: true,
                              header: ''
                          ),
                          series: <CircularSeries>[
                            PieSeries<CircularChartData, String>(
                                name: "Deal",
                                dataSource: chartData,
                                xValueMapper: (CircularChartData data, _) => data.name,
                                yValueMapper: (CircularChartData data, _) => data.percent,
                                dataLabelMapper: (CircularChartData data, _) => '${data.name}: %${data.percent}',
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                enableTooltip: true
                            )
                          ],
                        ) :
                        const Center(
                            child: Text('No data')
                        ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}

class CircularChartData{
  final String name;
  final double percent;
  CircularChartData({
    required this.name,
    required this.percent
});
}
