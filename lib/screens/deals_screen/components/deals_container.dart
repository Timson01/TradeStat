import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/screens/deals_detail_screen/deals_detail_screen.dart';

import '../../../models/deal.dart';
import '../../../styles/style_exports.dart';

class DealsContainer extends StatefulWidget {
  const DealsContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<DealsContainer> createState() => _DealsContainerState();
}

class _DealsContainerState extends State<DealsContainer> {
  void showSnackBar(BuildContext context, Deal deal) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

  undoDelete(deal) {
    setState(() {
      context.read<DealsBloc>().add(AddDeal(deal: deal));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var output = DateFormat('MM/dd/yyyy');
    context.read<DealsBloc>().add(const FetchDeals());
    return BlocBuilder<DealsBloc, DealsState>(
      builder: (context, state) {
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
          child: state.deals.isNotEmpty
              ? ListView.builder(
                  itemCount: state.deals.length,
                  itemBuilder: (_, index) => Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide()),
                    ),
                    child: InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed(DealsDetailScreen.id),
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            context
                                .read<DealsBloc>()
                                .add(DeleteDeal(id: state.deals[index].id!));
                          });
                          showSnackBar(context, state.deals[index]);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: Icon(Icons.delete_forever_rounded,
                              color: Colors.white),
                        ),
                        child: ListTile(
                            title: Text(state.deals[index].tickerName.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: colorBlue, fontSize: 24)),
                            subtitle: Text(
                                output.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        state.deals[index].dateCreated)),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: colorDarkGrey)),
                            trailing: RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: state.deals[index].amount >= 0 ? Colors.green : Colors.red),
                                children: [
                                  TextSpan(
                                    text: state.deals[index].amount.toString(),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: state.deals[index].amount >= 0 ? Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 20,
                                    ) : Icon(
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
              : Center(child: const Text('No data')),
        );
      },
    );
  }
}
