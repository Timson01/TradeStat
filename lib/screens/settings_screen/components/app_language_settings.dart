import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/generated/locale_keys.g.dart';
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

    if(context.locale == Locale('ru')) language = 'RU';

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
            LocaleKeys.settings_language_title.tr(),
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
                LocaleKeys.settings_choose_language.tr(),
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
                        context.setLocale(Locale('ru'));
                        context.read<DealsBloc>().add(ChangeHashtag(hashtag: 'Добавить новый хэштег'));
                      });
                      break;
                    case _PopupMenuValues.en:
                      setState(() {
                        language = 'EN';
                        context.setLocale(Locale('en'));
                        context.read<DealsBloc>().add(ChangeHashtag(hashtag: 'Add a new hashtag'));
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
