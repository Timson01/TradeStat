import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../styles/style_exports.dart';

class DealsInfoSection extends StatelessWidget {
  const DealsInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.85,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '1.03.22 - 20.03.22',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Income: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            RichText(
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
          ],
        ),
        SizedBox(height: height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Count of trades: ',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '20',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ]),
    );
  }
}
