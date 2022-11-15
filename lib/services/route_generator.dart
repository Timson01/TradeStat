import 'package:flutter/material.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
import 'package:trade_stat/screens/log_in_screen/log_in_screen.dart';
import 'package:trade_stat/screens/welcome_screen/welcome_screen.dart';
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

