import 'package:flutter/material.dart';
import 'package:trade_stat/styles/style_exports.dart';

class UserNameSettings extends StatelessWidget {
  const UserNameSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.85,
      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: colorDarkGrey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UserName',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Colors.black,
                letterSpacing: 0,
                fontSize: 16
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          TextField(
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(
                fontSize: 12,
                color: colorDarkGrey,
                letterSpacing: 1),
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 8),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: colorDarkGrey)),
                hintText: 'Enter UserName',
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(
                    fontSize: 12,
                    color: colorDarkGrey,
                    letterSpacing: 1)),
          ),
          SizedBox(
            height: height * 0.01,
          ),
        ],
      ),
    );
  }
}
