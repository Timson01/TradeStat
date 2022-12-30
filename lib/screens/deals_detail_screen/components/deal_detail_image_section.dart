import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles/style_exports.dart';

class DealDetailImageSection extends StatelessWidget {
  const DealDetailImageSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: SvgPicture.asset(noDataImage, fit: BoxFit.cover),
    );
  }
}