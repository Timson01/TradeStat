import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/screens/rules_screen/components/add_edit_dialog.dart';
import 'package:trade_stat/screens/rules_screen/components/delete_dialog.dart';
import 'package:trade_stat/styles/app_colors.dart';

import '../../../models/rule.dart';

class RulesContainer extends StatefulWidget {
  const RulesContainer({Key? key}) : super(key: key);

  @override
  State<RulesContainer> createState() => _RulesContainerState();
}

class _RulesContainerState extends State<RulesContainer> {
  List<Color> colors = <Color>[
    colorRuleRed,
    colorRuleYellow,
    colorRuleGreen,
    colorRulePurple,
  ];

  @override
  void initState() {
    context.read<RulesBloc>().add(const FetchRules());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.9,
      height: height * 0.7,
      child: BlocBuilder<RulesBloc, RulesState>(
        builder: (context, state) {
          if (state is RulesLoaded) {
            return state.rules.isNotEmpty
                ? MasonryGridView.count(
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    crossAxisCount: 2,
                    itemCount: state.rules.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors[state.rules[index].ruleColor],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: IntrinsicHeight(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.rules[index].ruleName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: 2),
                                ),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeleteDialog(rule: state.rules[index]);
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.delete_forever_rounded,
                                        size: 22,
                                        color: Colors.white))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.rules[index].description,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      color: Colors.white,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AddEditDialog(
                                            rule: state.rules[index]);
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit_note_rounded,
                                      size: 23, color: Colors.white)),
                            )
                          ]),
                        ),
                      );
                    })
                : const Center(child: Text('NO DATA'));
          } else {
            return const Center(child: Text('NO DATA'));
          }
        },
      ),
    );
  }
}
