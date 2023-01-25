import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/screens/deals_detail_screen/deals_detail_screen.dart';
import '../../../models/deal.dart';
import '../../../styles/style_exports.dart';

class DealsContainer extends StatelessWidget {

  final List<Deal> dealsList;

  const DealsContainer({
    Key? key,
    required this.dealsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var output = DateFormat('yyyy/MM/dd');

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    undoDelete(deal) {
      context.read<DealsBloc>().add(AddDeal(deal: deal));
    }

    void showSnackBar(BuildContext context, Deal deal) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1500),
        content: Text(
          '${deal.tickerName} deleted',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.white, fontSize: 14, letterSpacing: 1),
        ),
        action: SnackBarAction(
          textColor: colorBlue,
          label: "UNDO DEAL",
          onPressed: () {
            undoDelete(deal);
          },
        ),
      ));
    }

    List<Deal> deals = dealsList;

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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.05),
        width: width * 0.85,
        height: height * 0.48,
        child: deals.isNotEmpty
              ? ListView.builder(
                  itemCount: deals.length,
                  itemBuilder: (_, index) => Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(DealsDetailScreen.id, arguments: deals[index]);
                      },
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context
                              .read<DealsBloc>()
                              .add(DeleteDeal(id: deals[index].id!));
                          showSnackBar(context, deals[index]);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete_forever_rounded,
                              color: Colors.white),
                        ),
                        child: ListTile(
                            title: Text(
                                deals[index].tickerName.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: colorBlue, fontSize: 24)),
                            subtitle: Text(
                                output.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        deals[index].dateCreated)),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: colorDarkGrey)),
                            trailing: RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: deals[index].income >= 0
                                            ? Colors.green
                                            : Colors.red),
                                children: [
                                  TextSpan(
                                    text: deals[index].income.toString(),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: deals[index].income >= 0
                                        ? const Icon(
                                            Icons.arrow_upward,
                                            color: Colors.green,
                                            size: 20,
                                          )
                                        : const Icon(
                                            Icons.arrow_downward,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                )
              : const Center(child: Text('No data')));
  }
}
