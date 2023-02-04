import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/generated/codegen_loader.g.dart';
import 'package:trade_stat/repository/deals_repository.dart';
import 'package:trade_stat/repository/rules_repository.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
import 'package:trade_stat/screens/welcome_screen/welcome_screen.dart';
import 'package:trade_stat/services/app_theme.dart';
import 'package:trade_stat/services/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
      () => runApp(EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ru')],
          path: 'assets/translations',
          assetLoader: CodegenLoader(),
          // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          child: const MyApp())),
      storage: storage);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      return WelcomeScreen.id;
    } else {
      // Set the flag to true at the end of onboarding screen if everything is successfull and so I am commenting it out
      // await prefs.setBool('seen', true);
      await prefs.setBool('seen', true);
      return DescriptionScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      DealsBloc(dealsRepository: DealsRepository()),
                ),
                BlocProvider(
                  create: (context) =>
                      RulesBloc(rulesRepository: RulesRepository()),
                ),
              ],
              child: MaterialApp(
                title: 'Flutter Trade Stat',
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: AppThemes.appThemeData[AppTheme.lightTheme],
                initialRoute: snapshot.data,
                onGenerateRoute: RouteGenerator.generateRoute,
              ),
            );
          }
        });
  }
}
