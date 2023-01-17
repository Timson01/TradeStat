import 'package:flutter/material.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/edit_deal_screen.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';
import 'package:trade_stat/styles/app_colors.dart';

import '../../models/deal.dart';
import 'components/deal_detail_card.dart';
import 'components/deal_detail_image_section.dart';
import 'components/deals_detail_info_section.dart';

class InheritedDealsDetailScreen extends InheritedWidget {
  final Deal currentDeal;
  final _DealsDetailScreenState dealsDetailScreen;

  const InheritedDealsDetailScreen({
    super.key,
    required this.dealsDetailScreen,
    required this.currentDeal,
    required Widget child,
  }) : super(child: child);

  static _DealsDetailScreenState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<InheritedDealsDetailScreen>()!
      .dealsDetailScreen;

  @override
  bool updateShouldNotify(InheritedDealsDetailScreen oldWidget) {
    return oldWidget.currentDeal != currentDeal;
  }
}

class DealsDetailScreen extends StatefulWidget {
  final Deal currentDeal;

  const DealsDetailScreen({Key? key, required this.currentDeal})
      : super(key: key);
  static const id = 'deals_detail_screen';

  @override
  State<DealsDetailScreen> createState() => _DealsDetailScreenState();
}

class _DealsDetailScreenState extends State<DealsDetailScreen> {
  late Deal currentDeal;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    currentDeal = widget.currentDeal;
    return SafeArea(
      child: InheritedDealsDetailScreen(
        dealsDetailScreen: this,
        currentDeal: widget.currentDeal,
        child: Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: width * 0.9,
                  padding: EdgeInsets.symmetric(vertical: height * 0.05),
                  child: Column(
                    children: [
                      const DealDetailCard(),
                      SizedBox(height: height * 0.03),
                      const DealDetailImageSection(),
                      SizedBox(height: height * 0.03),
                      const DealsDetailInfoSection(),
                      SizedBox(height: height * 0.03),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: const Icon(Icons.arrow_back_ios_new_rounded,
                                  color: colorBlue, size: 25),
                              onTap: () => Navigator.of(context).pushReplacementNamed(DealsScreen.id),
                            ),
                            GestureDetector(
                                onTap: () => Navigator.of(context).pushReplacementNamed(
                                    EditDealScreen.id,
                                    arguments: currentDeal),
                                child: const Icon(Icons.edit_note_rounded,
                                    color: colorBlue, size: 28)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
