import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/style_exports.dart';
import 'components/add_edit_top_section.dart';
import 'components/edit_section.dart';

class AddDealScreen extends StatefulWidget {
  const AddDealScreen({Key? key}) : super(key: key);
  static const id = 'add_deal_screen';

  @override
  State<AddDealScreen> createState() => _AddDealScreenState();

}

class _AddDealScreenState extends State<AddDealScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        SvgPicture.asset(addEditDealBackground, fit: BoxFit.cover),
        Positioned(
          top: height * 0.05,
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
                  const AddEditTopSection(id: AddDealScreen.id),
                  SizedBox(height: height * 0.05),
                  Container(
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                    ),
                    child: const EditSection(id: AddDealScreen.id),
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