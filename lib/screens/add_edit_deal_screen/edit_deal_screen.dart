import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/deal.dart';
import '../../styles/app_images.dart';
import 'components/add_edit_top_section.dart';
import 'components/edit_section.dart';

class InheritedEditDealScreen extends InheritedWidget {
  final Deal currentDeal;
  final _EditDealScreenState editDealsScreen;

  const InheritedEditDealScreen({
    super.key,
    required this.editDealsScreen,
    required this.currentDeal,
    required Widget child,
  }) : super(child: child);

  static _EditDealScreenState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<InheritedEditDealScreen>()!
      .editDealsScreen;

  @override
  bool updateShouldNotify(InheritedEditDealScreen oldWidget) {
    return oldWidget.currentDeal != currentDeal;
  }
}

class EditDealScreen extends StatefulWidget {
  final Deal currentDeal;
  const EditDealScreen({Key? key, required this.currentDeal}) : super(key: key);
  static const id = 'edit_deal_screen';

  @override
  State<EditDealScreen> createState() => _EditDealScreenState();
}

class _EditDealScreenState extends State<EditDealScreen> {

  late Deal currentDeal;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    currentDeal = widget.currentDeal;

    return Stack(
      children: <Widget>[
        SvgPicture.asset(addEditDealBackground, fit: BoxFit.cover),
        Positioned(
          top: height * 0.1,
          left: width * 0.075,
          right: width * 0.075,
          bottom: height * 0.05,
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: InheritedEditDealScreen(
              editDealsScreen: this,
              currentDeal: widget.currentDeal,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  children: [
                    const AddEditTopSection(id: EditDealScreen.id),
                    SizedBox(height: height * 0.05),
                    Container(
                      width: width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white
                      ),
                      child: const EditSection(id: EditDealScreen.id),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
