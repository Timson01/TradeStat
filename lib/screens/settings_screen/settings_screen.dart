import 'package:flutter/material.dart';
import 'package:trade_stat/screens/settings_screen/components/app_language_settings.dart';
import '../deals_screen/deals_screen.dart';
import 'components/user_name_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const id = 'settings_screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              child: SizedBox(
                width: width * 0.85,
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(DealsScreen.id);
                                },
                                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                    color: Colors.black, size: 25)
                            ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const UserNameSettings(),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const AppLanguageSettings()
                    ],
                  ),
              ),
            ),
          ),
          )
      );
  }
}