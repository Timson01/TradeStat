import 'package:flutter/material.dart';
import 'package:trade_stat/styles/app_images.dart';

import 'components/deals_button_section.dart';
import 'components/deals_container.dart';
import 'components/deals_info_section.dart';
import 'components/deals_top_section.dart';
import 'components/header_drawer.dart';

class InheritedDealsScreen extends InheritedWidget {
  final ValueNotifier<String> userSearchInput;
  final _DealsScreenState dealsScreenWidgetState;

  const InheritedDealsScreen({
    super.key,
    required this.dealsScreenWidgetState,
    required this.userSearchInput,
    required Widget child,
  }) : super(child: child);

  static _DealsScreenState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<InheritedDealsScreen>()!
      .dealsScreenWidgetState;

  @override
  bool updateShouldNotify(InheritedDealsScreen oldWidget) {
    return oldWidget.userSearchInput != userSearchInput;
  }
}

class DealsScreen extends StatefulWidget {
  const DealsScreen({Key? key}) : super(key: key);
  static const id = 'deals_screen';

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  ValueNotifier<String> userSearchInput = ValueNotifier<String>('');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var currentPage = DrawerSections.deals;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if (currentPage == DrawerSections.deals) {
      print('deals');
    } else if (currentPage == DrawerSections.statistic) {
      print('statistic');
    } else if (currentPage == DrawerSections.settings) {
      print('settings');
    } else if (currentPage == DrawerSections.help) {
      print('help');
    }

    return InheritedDealsScreen(
      userSearchInput: userSearchInput,
      dealsScreenWidgetState: this,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeaderDrawer(),
                  DrawerList(),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                DealsTopSection(
                    scaffoldKey: _scaffoldKey,
                    callback: (val) =>
                        setState(() => userSearchInput.value = val)),
                const DealsInfoSection(),
                SizedBox(height: height * 0.03),
                const DealsButtonSection(),
                SizedBox(height: height * 0.03),
                const DealsContainer()
              ]),
            ),
          )),
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
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30),
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
