import 'package:flutter/material.dart';

import 'components/deals_button_section.dart';
import 'components/deals_container.dart';
import 'components/deals_info_section.dart';
import 'components/deals_top_section.dart';

class InheritedDealsScreen extends InheritedWidget{

  final String userSearchInput;
  final _DealsScreenState dealsScreenWidgetState;

  const InheritedDealsScreen({
    super.key,
    required this.dealsScreenWidgetState,
    required this.userSearchInput,
    required Widget child,
  }) : super(child: child);

  static _DealsScreenState of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<InheritedDealsScreen>()!.dealsScreenWidgetState;

  @override
  bool updateShouldNotify(InheritedDealsScreen oldWidget) {
    return oldWidget.userSearchInput != userSearchInput;
  }
  
} 

class DealsScreen extends StatefulWidget {
  const DealsScreen({Key? key}) : super(key: key);
  static const id = 'deals_screen';

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {

  String userSearchInput = '';

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    return InheritedDealsScreen(
      userSearchInput: userSearchInput,
      dealsScreenWidgetState: this,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            DealsTopSection(callback: (val) => setState(() => userSearchInput = val)),
            const DealsInfoSection(),
            SizedBox(height: height * 0.03),
            const DealsButtonSection(),
            SizedBox(height: height * 0.03),
            DealsContainer()
          ]),
        ),
      )),
    );
  }
}




