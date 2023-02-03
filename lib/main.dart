import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/generated/codegen_loader.g.dart';
import 'package:trade_stat/repository/deals_repository.dart';
import 'package:trade_stat/repository/rules_repository.dart';
import 'package:trade_stat/screens/description_screen/description_screen.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DealsBloc(dealsRepository: DealsRepository()),
        ),
        BlocProvider(
          create: (context) => RulesBloc(rulesRepository: RulesRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Trade Stat',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppThemes.appThemeData[AppTheme.lightTheme],
        initialRoute: DescriptionScreen.id,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
