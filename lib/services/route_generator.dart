import 'package:flutter/material.dart';
import 'package:trade_stat/models/charts_model.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/add_deal_screen.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/edit_deal_screen.dart';
import 'package:trade_stat/screens/charts/percentage_chart_screen.dart';
import 'package:trade_stat/screens/deals_detail_screen/deals_detail_screen.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
import 'package:trade_stat/screens/rules_screen/rules_screen.dart';
import 'package:trade_stat/screens/statistic_screen/statistic_screen.dart';
import '../models/deal.dart';
import '../screens/charts/named_income_chart_screen.dart';
import '../screens/settings_screen/settings_screen.dart';
import '../screens/strategy_screen/strategy_screen.dart';
import 'custom_page_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case DescriptionScreen.id:
        return CustomPageRoute(child: DescriptionScreen());
      case DealsScreen.id:
        return CustomPageRoute(child: DealsScreen());
      case AddDealScreen.id:
        return CustomPageRoute(child: AddDealScreen());
      case EditDealScreen.id:
        return CustomPageRoute(child: EditDealScreen(currentDeal: routeSettings.arguments as Deal));
      case DealsDetailScreen.id:
        return CustomPageRoute(child: DealsDetailScreen(currentDeal: routeSettings.arguments as Deal));
      case RulesScreen.id:
        return CustomPageRoute(child: RulesScreen());
      case StrategyScreen.id:
        return CustomPageRoute(child: StrategyScreen());
      case StatisticScreen.id:
        return CustomPageRoute(child: StatisticScreen());
      case NamedIncomeChartScreen.id:
        return CustomPageRoute(child: NamedIncomeChartScreen(chartModel: routeSettings.arguments as ChartsModel));
      case PercentageChartScreen.id:
        return CustomPageRoute(child: PercentageChartScreen(chartModel: routeSettings.arguments as ChartsModel));
      case SettingsScreen.id:
        return CustomPageRoute(child: SettingsScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text("Error"),
        ),
      );
    }
    );
  }
}

