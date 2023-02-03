import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/generated/locale_keys.g.dart';
import 'package:trade_stat/styles/app_colors.dart';
import 'package:trade_stat/styles/app_images.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      width: double.infinity,
      height: height * 0.35,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(appLogoImage),
              ),
            ),
          ),
          Text(
            LocaleKeys.hello.tr(),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: colorDarkGrey,
              letterSpacing: context.locale == Locale('ru') ? 0 : 1,
              fontSize: context.locale == Locale('ru') ? 16 : 18,
            ),
          ),
          Text(
            "Timur Kreminskiy",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Colors.black,
              fontSize: 24
            ),
          ),
          InkWell(
            onTap: (){},
            child: Text(
              LocaleKeys.support_developers.tr(),
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: colorBlue,
                letterSpacing: context.locale == Locale('ru') ? 0 : 2,
                fontSize: context.locale == Locale('ru') ? 14 : 16,
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
