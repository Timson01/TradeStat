import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
import 'package:trade_stat/services/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: DescriptionScreen.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
