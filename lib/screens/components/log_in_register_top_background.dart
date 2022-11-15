import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/screens/log_in_screen/log_in_screen.dart';

import '../../styles/app_images.dart';

class LogInRegisterTopBackground extends StatelessWidget {
  String id;

  LogInRegisterTopBackground({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(topBackground, width: width, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Text(
              id == LogInScreen.id ?
              'Welcome \nBack' : 'Create an\naccount',
              style: Theme.of(context).textTheme.headline4,
            ),
          )
        ]
    );
  }
}
