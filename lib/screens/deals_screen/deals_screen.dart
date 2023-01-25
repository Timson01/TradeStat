import 'package:flutter/material.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/styles/app_images.dart';

import '../../models/deal.dart';
import '../statistic_screen/statistic_screen.dart';
import 'components/deals_button_section.dart';
import 'components/deals_container.dart';
import 'components/deals_info_section.dart';
import 'components/deals_top_section.dart';
import 'components/header_drawer.dart';

class InheritedDealsScreen extends InheritedWidget {
  final _DealsScreenState dealsScreen;
  final List<int> dateTimeRange;

  const InheritedDealsScreen({
    super.key,
    required this.dealsScreen,
    required this.dateTimeRange,
    required Widget child,
  }) : super(child: child);

  static _DealsScreenState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<InheritedDealsScreen>()!
      .dealsScreen;

  @override
  bool updateShouldNotify(InheritedDealsScreen oldWidget) {
    return oldWidget.dateTimeRange != dateTimeRange;
  }
}

class DealsScreen extends StatefulWidget {
  const DealsScreen({Key? key}) : super(key: key);
  static const id = 'deals_screen';

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {

  ValueNotifier<List<int>> dateTimeRange = ValueNotifier([]);
  ValueNotifier<String> userSearchInput = ValueNotifier<String>('');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int initCounter = 0;
  var currentPage = DrawerSections.deals;
  bool doItJustOnce = false;
  List<Deal> filteredList = <Deal>[];
  ValueNotifier<List<Deal>> list = ValueNotifier([]);

  void filterList(value) {
    setState(() {
      filteredList = list.value
          .where((text) => text.tickerName
          .toLowerCase()
          .contains(value.toString().toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    context.read<DealsBloc>().add(const FetchDeals());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    userSearchInput.addListener(() => filterList(userSearchInput.value));
    dateTimeRange.addListener(() => setState(() {}));
    list.addListener(() => setState(() {
      filteredList = list.value.where((text) => text.tickerName
          .toLowerCase()
          .contains(userSearchInput.value.toString().toLowerCase()))
          .toList();
    }));

    return InheritedDealsScreen(
      dateTimeRange: dateTimeRange.value,
      dealsScreen: this,
      child: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HeaderDrawer(),
                    DrawerList(),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: BlocBuilder<DealsBloc, DealsState>(
                  builder: (context, state) {
                    if (!doItJustOnce) {
                      list.value = state.deals;
                      dateTimeRange.value = [state.deals[state.deals.length - 1].dateCreated, state.deals[0].dateCreated];
                      doItJustOnce = !doItJustOnce;
                    }
                    if(list != state.deals){
                      list.value = state.deals;
                    }
                    return Column(children: [
                      DealsTopSection(
                          scaffoldKey: _scaffoldKey,
                          callback: (val) => userSearchInput.value = val),
                      DealsInfoSection(dealsList: filteredList),
                      SizedBox(height: height * 0.03),
                      const DealsButtonSection(),
                      SizedBox(height: height * 0.03),
                      DealsContainer(dealsList: filteredList)
                    ]);
                  },
                ),
              ),
            )
      ),
    );
  }

  Widget DrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Deals", Icons.dashboard_outlined,
              currentPage == DrawerSections.deals ? true : false),
          menuItem(2, "Statistic", Icons.insert_chart_outlined_rounded,
              currentPage == DrawerSections.statistic ? true : false),
          menuItem(3, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(4, "Help", Icons.help_outline_rounded,
              currentPage == DrawerSections.help ? true : false),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                icon: Image.asset(globeWebImage),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(instagramImage),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.deals;
            } else if (id == 2) {
              currentPage = DrawerSections.statistic;
              Navigator.of(context).pushReplacementNamed(StatisticScreen.id);
            } else if (id == 3) {
              currentPage = DrawerSections.settings;
            } else if (id == 4) {
              currentPage = DrawerSections.help;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  deals,
  statistic,
  settings,
  help,
}
