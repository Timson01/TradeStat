import 'package:flutter/material.dart';

import '../../deals_screen/deals_screen.dart';

class StatisticTopSection extends StatelessWidget {
  const StatisticTopSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 22,
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.black),
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed(DealsScreen.id),
              ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Statistics',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontSize: 28, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
