import 'package:flutter/material.dart';

import '../../../styles/style_exports.dart';

class DealDetailCard extends StatelessWidget {
  const DealDetailCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
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
      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'UTC',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: colorBlue, fontSize: 26),
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.red),
                  children: const [
                    TextSpan(text: '30.75 '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '15.03.22',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: colorDarkGrey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
