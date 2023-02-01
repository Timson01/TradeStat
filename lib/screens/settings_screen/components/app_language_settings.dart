import 'package:flutter/material.dart';
import 'package:trade_stat/styles/style_exports.dart';

enum _PopupMenuValues { ru, en }

class AppLanguageSettings extends StatefulWidget {
  const AppLanguageSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLanguageSettings> createState() => _AppLanguageSettingsState();
}

class _AppLanguageSettingsState extends State<AppLanguageSettings> {

  String language = 'EN';

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.85,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: Colors.black, letterSpacing: 0, fontSize: 16),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose language',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.black, letterSpacing: 0),
              ),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                onSelected: (value) {
                  switch (value) {
                    case _PopupMenuValues.ru:
                      setState(() {
                        language = 'RU';
                      });
                      break;
                    case _PopupMenuValues.en:
                      setState(() {
                        language = 'EN';
                      });
                      break;
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topRight: const Radius.circular(0))),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        padding: const EdgeInsets.only(right: 50, left: 20),
                        value: _PopupMenuValues.ru,
                        child: Text(
                          'RU',
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: colorBlue,
                                  ),
                        )),
                    PopupMenuItem(
                        padding: const EdgeInsets.only(right: 50, left: 20),
                        value: _PopupMenuValues.en,
                        child: Text(
                          'EN',
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: colorBlue,
                                  ),
                        )),
                  ];
                },
                child: Text(
                  language,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: colorBlue,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
        ],
      ),
    );
  }
}
