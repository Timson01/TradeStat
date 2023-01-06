import 'package:flutter/material.dart';
import 'package:trade_stat/screens/rules_screen/components/rules_top_section.dart';

class InheritedRulesScreen extends InheritedWidget {
  final ValueNotifier<String> userSearchInput;
  final _RulesScreenState rulesScreenWidgetState;

  const InheritedRulesScreen({
    super.key,
    required this.rulesScreenWidgetState,
    required this.userSearchInput,
    required Widget child,
  }) : super(child: child);

  static _RulesScreenState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<InheritedRulesScreen>()!
      .rulesScreenWidgetState;

  @override
  bool updateShouldNotify(InheritedRulesScreen oldWidget) {
    return oldWidget.userSearchInput != userSearchInput;
  }
}

class RulesScreen extends StatefulWidget {
  const RulesScreen({Key? key}) : super(key: key);
  static const id = 'rules_screen';

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {

  ValueNotifier<String> userSearchInput = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return InheritedRulesScreen(
      rulesScreenWidgetState: this,
      userSearchInput: userSearchInput,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                RulesTopSection(callback: (val) => setState(() => userSearchInput.value = val))
              ],
            )
          ),
        ),
      ),
    );
  }
}
