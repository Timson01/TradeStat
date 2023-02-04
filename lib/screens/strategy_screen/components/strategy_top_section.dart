import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/generated/locale_keys.g.dart';
import '../../deals_screen/deals_screen.dart';

class StrategyTopSection extends StatefulWidget {
  const StrategyTopSection({
    Key? key,
  }) : super(key: key);

  @override
  State<StrategyTopSection> createState() => _StrategyTopSectionState();
}

class _StrategyTopSectionState extends State<StrategyTopSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 22, color: Colors.white),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(DealsScreen.id),
        ),
        Text(
          LocaleKeys.my_strategy.tr(),
          style: Theme
              .of(context)
              .textTheme
              .headline5
              ?.copyWith(
              fontSize: 24,
              color: Colors.white,
              letterSpacing: context.locale == Locale('ru') ? 2 : 4
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
