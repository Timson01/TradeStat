import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trade_stat/styles/app_colors.dart';

class RulesContainer extends StatefulWidget {
  const RulesContainer({Key? key}) : super(key: key);

  @override
  State<RulesContainer> createState() => _RulesContainerState();
}

class _RulesContainerState extends State<RulesContainer> {
  List<int> items = <int>[];
  List<Color> colors = <Color>[colorRuleGreen, colorRulePurple, colorRuleRed, colorRuleYellow, colorRuleGreen, colorRulePurple, colorRuleRed, colorRuleYellow];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    for (int i = 1; i < 8; i++) {
      items.add(i);
    }
    return Container(
      width: width * 0.9,
      height: height * 0.9,
      child: MasonryGridView.count(
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          crossAxisCount: 2,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors[index],
              ),
              padding: EdgeInsets.all(12),
              child: IntrinsicHeight(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rule ${items[index]}',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 2
                        ),
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: const Icon(Icons.edit_note_rounded,
                              size: 23, color: Colors.white))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. '
                        'Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur,'
                        ' ultrices mauris. Maecenas vitae mattis tellus..',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
