import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/repository/deals_repository.dart';
import 'package:trade_stat/repository/rules_repository.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
import 'package:trade_stat/services/app_theme.dart';
import 'package:trade_stat/services/route_generator.dart';

import 'models/deal.dart';
import 'models/rule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(() => runApp(const MyApp()), storage: storage);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                DealsBloc(dealsRepository: DealsRepository()),
        ),
        BlocProvider(
          create: (context) =>
              RulesBloc(rulesRepository: RulesRepository())..add(AddRule(rule: Rule(
                ruleName: 'Rule 7',
                description: 'Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit urna. Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi.',
                ruleColor: 0
              ))),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Trade Stat',
        theme: AppThemes.appThemeData[AppTheme.lightTheme],
        initialRoute: DescriptionScreen.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
