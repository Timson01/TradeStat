import 'package:flutter/material.dart';

import '../../../models/deal.dart';
import '../deals_detail_screen.dart';

class DealsDetailInfoSection extends StatelessWidget {
  const DealsDetailInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Deal currentDeal = InheritedDealsDetailScreen.of(context).currentDeal;
    return Container(
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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.03),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ----- Description Section -----
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  currentDeal.description == '' ? 'You didn\'t put anything here' : currentDeal.description,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black,
                      letterSpacing: 0
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            // ----- Hashtag Section -----
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hashtag',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  currentDeal.hashtag == '' ? 'You didn\'t put anything here' : '#${currentDeal.hashtag}',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black,
                      letterSpacing: 0
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            // ----- Position Section -----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Position',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  currentDeal.position,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: currentDeal.position == 'Long' ? Colors.green : Colors.red,
                      letterSpacing: 0
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            // ----- Number of stocks Section -----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Number of stocks',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  currentDeal.numberOfStocks.toString(),
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black,
                      letterSpacing: 0
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.03),
            // ----- Amount of Deal Section -----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount of deal',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  currentDeal.amount.toString(),
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black,
                      letterSpacing: 0
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
