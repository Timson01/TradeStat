import 'package:flutter/material.dart';
import '../../../styles/style_exports.dart';

class StrategyEditSection extends StatefulWidget {
  const StrategyEditSection({
    Key? key,
  }) : super(key: key);

  @override
  State<StrategyEditSection> createState() => _StrategyEditSectionState();
}

class _StrategyEditSectionState extends State<StrategyEditSection> {

  TextEditingController _strategyController = TextEditingController(
      text: 'Here you can store all your knowledge and return to it when you need it'
  );

  @override
  void dispose() {
    _strategyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
      constraints: BoxConstraints(minWidth: width * 0.85, maxHeight: height * 0.7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            border: Border.all(color: colorBlue)),
        child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _strategyController,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(
                    fontSize: 15,
                    color: colorDarkGrey,
                    letterSpacing: 1),
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    ),
                ),
            );
  }
}
