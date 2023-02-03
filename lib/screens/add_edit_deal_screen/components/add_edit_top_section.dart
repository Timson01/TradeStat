import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/generated/locale_keys.g.dart';
import '../../deals_screen/deals_screen.dart';
import '../add_deal_screen.dart';

class AddEditTopSection extends StatefulWidget {
  final String id;
  const AddEditTopSection({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  State<AddEditTopSection> createState() => _AddEditTopSectionState();
}

class _AddEditTopSectionState extends State<AddEditTopSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 22, color: Colors.white),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(DealsScreen.id)
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.id == AddDealScreen.id ? LocaleKeys.create_new_deal.tr() : LocaleKeys.edit_deal.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(
                  fontSize: context.locale == Locale('ru') ? 22 : 24,
                  letterSpacing: context.locale == Locale('ru') ? 2 : 4,
                  color: Colors.white
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              LocaleKeys.it_simple.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(
                  fontSize: context.locale == Locale('ru') ? 20 : 22,
                  letterSpacing: context.locale == Locale('ru') ? 2 : 4,
                  color: Colors.white
              ),
              textAlign: TextAlign.right,
            ),
          ],
        )
      ],
    );
  }
}
