import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/style_exports.dart';
import 'components/add_edit_top_section.dart';
import 'components/edit_section.dart';

class AddEditDealScreen extends StatefulWidget {
  const AddEditDealScreen({Key? key}) : super(key: key);
  static const id = 'add_edit_deal_screen';

  @override
  State<AddEditDealScreen> createState() => _AddEditDealScreenState();

}

class _AddEditDealScreenState extends State<AddEditDealScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
                children: [
                  AddEditTopSection(),
                  SizedBox(height: height * 0.05),
                  Container(
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                    ),
                    child: EditSection(),
                    ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}