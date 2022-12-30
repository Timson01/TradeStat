import 'package:flutter/material.dart';
import 'package:trade_stat/styles/app_colors.dart';

import 'components/deal_detail_card.dart';
import 'components/deal_detail_image_section.dart';
import 'components/deals_detail_info_section.dart';

class DealsDetailScreen extends StatelessWidget {
  const DealsDetailScreen({Key? key}) : super(key: key);
  static const id = 'deals_detail_screen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                          offset: const Offset(0, 3), // changes position of shadow
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
                          onTap: () => Navigator.pop(context),
                        ),
                        GestureDetector(
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
    );
  }
}
