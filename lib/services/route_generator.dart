import 'package:flutter/material.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/add_deal_screen.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/edit_deal_screen.dart';
import 'package:trade_stat/screens/deals_detail_screen/deals_detail_screen.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
import 'package:trade_stat/screens/log_in_screen/log_in_screen.dart';
import 'package:trade_stat/screens/registration_screen/registration_screen.dart';
import 'package:trade_stat/screens/rules_screen/rules_screen.dart';
import 'package:trade_stat/screens/welcome_screen/welcome_screen.dart';
import '../models/deal.dart';
import '../screens/strategy_screen/strategy_screen.dart';
import 'custom_page_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case DescriptionScreen.id:
        return CustomPageRoute(child: DescriptionScreen());
      case WelcomeScreen.id:
          return CustomPageRoute(child: WelcomeScreen());
      case LogInScreen.id:
        return CustomPageRoute(child: LogInScreen());
      case RegistrationScreen.id:
        return CustomPageRoute(child: RegistrationScreen());
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

