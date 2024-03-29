import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/generated/codegen_loader.g.dart';
import 'package:trade_stat/repository/deals_repository.dart';
import 'package:trade_stat/repository/rules_repository.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
import 'package:trade_stat/services/app_theme.dart';
import 'package:trade_stat/services/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
      return DealsScreen.id;
    } else {
      await prefs.setBool('seen', true);
      return DescriptionScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(),
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
