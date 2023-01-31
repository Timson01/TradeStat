import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/models/charts_model.dart';
import 'package:trade_stat/styles/app_colors.dart';

import '../../models/deal.dart';

class NamedIncomeChartScreen extends StatefulWidget {
  final ChartsModel chartModel;

  const NamedIncomeChartScreen({
    Key? key,
    required this.chartModel
  }) : super(key: key);
  static const id = 'named_income_chart_screen';

  @override
  State<NamedIncomeChartScreen> createState() => _NamedIncomeChartScreenState();
}

class _NamedIncomeChartScreenState extends State<NamedIncomeChartScreen> {

  List<Deal> filteredList = [];
  String title = '';

  @override
  void initState() {
    if(widget.chartModel.position == 'All'){
      context.read<DealsBloc>().add(FetchDealsWithDate(
        startDate: widget.chartModel.dateTimeRange.start.millisecondsSinceEpoch,
        endDate: widget.chartModel.dateTimeRange.end.millisecondsSinceEpoch,
      ));
    }else{
      context.read<DealsBloc>().add(FetchDealsByPosition(
          startDate: widget.chartModel.dateTimeRange.start.millisecondsSinceEpoch,
          endDate: widget.chartModel.dateTimeRange.end.millisecondsSinceEpoch,
          position: widget.chartModel.position
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop;
              return true;
            },
            child: BlocBuilder<DealsBloc, DealsState>(
              builder: (context, state) {
                if(state.deals.isNotEmpty){
                  filteredList = widget.chartModel.hashtag ? state.deals.where((deal) =>  deal.hashtag
                      .toLowerCase()
                      .contains(widget.chartModel.name.toLowerCase()))
                      .toList() :
                  state.deals.where((deal) =>  deal.tickerName
                      .toLowerCase()
                      .contains(widget.chartModel.name.toLowerCase()))
                      .toList();
                  title = widget.chartModel.hashtag ?
                  'Income Chart. Position - ${widget.chartModel.position}.\nHashtag: ${widget.chartModel.name}'
                      : 'Income Chart. Position - ${widget.chartModel.position}.\nTickerSymbol: ${widget.chartModel.name}';
                }
                return SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                      enableDoubleTapZooming: true,
                      enablePanning: true,
                      enablePinching: true,
                      enableSelectionZooming: true
                  ),
                  palette: const <Color>[
                    colorBlue,
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
                  series: <ChartSeries<Deal, String>>[
                    LineSeries<Deal, String>(
                      name: "Deal",
                        dataSource: filteredList,
                        xValueMapper: (Deal deal, _) => DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(deal.dateCreated)).toString(),
                        yValueMapper: (Deal deal, _) => deal.income,
                        dataLabelMapper: (Deal deal, _) => '${deal.tickerName.toUpperCase()}\nIncome: ${deal.income}',
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                        markerSettings: MarkerSettings(
                            isVisible: true
                        ),
                        enableTooltip: true
                    )
                  ],
                );
              },
            ),
          ),
        )
    );
  }
}

class ChartData {
  ChartData(this.day, this.income);
  final String day;
  final double income;
}
