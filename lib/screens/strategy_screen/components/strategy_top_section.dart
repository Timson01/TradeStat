import 'package:flutter/material.dart';
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
              size: 25, color: Colors.white),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(DealsScreen.id),
        ),
        Text(
          'My Strategy',
          style: Theme
              .of(context)
              .textTheme
              .headline5
              ?.copyWith(fontSize: 24, color: Colors.white),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
