import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/styles/app_colors.dart';
import 'package:trade_stat/styles/app_images.dart';

import 'components/deals_button_section.dart';
import 'components/deals_info_section.dart';
import 'components/deals_top_section.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({Key? key}) : super(key: key);
  static const id = 'deals_screen';

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> items = List<String>.generate(100, (i) => 'UTC');
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          DealsTopSection(),
          DealsInfoSection(),
          SizedBox(height: height * 0.03),
          DealsButtonSection(),
          SizedBox(height: height * 0.03),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.05),
            width: width * 0.85,
            height: height * 0.5,
            child: ListView.builder(
              itemCount: items.length,
                itemBuilder: (_, index) =>
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: ListTile(
                      title: Text(items[index],
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: colorBlue,
                        fontSize: 24
                      )),
                      subtitle: Text(
                        '24.03.23',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: colorDarkGrey
                        )
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.green),
                          children: [
                            TextSpan(text: '30.75 '),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
            )
          )
        ]),
      ),
    ));
  }
}


