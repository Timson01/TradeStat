import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../styles/style_exports.dart';

typedef StringCallback = void Function(String userSearchInput);

class DealsTopSection extends StatefulWidget {
  final StringCallback callback;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DealsTopSection({Key? key, required this.scaffoldKey, required this.callback}) : super(key: key);

  @override
  State<DealsTopSection> createState() => _DealsTopSectionState();
}

class _DealsTopSectionState extends State<DealsTopSection> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SvgPicture.asset(topBackground, width: width, fit: BoxFit.cover),
        Positioned(
            top: height * 0.05,
            left: width * 0.075,
            right: width * 0.075,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
                    child: SvgPicture.asset(
                      burgerMenuIcon,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    LocaleKeys.deals_title.tr(),
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white,
                      fontSize: context.locale == Locale('ru') ? 30 : 32,
                      letterSpacing: context.locale == Locale('ru') ? 2 : 4,
                        ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
              SizedBox(height: height * 0.04),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: PhysicalModel(
                  elevation: 15.0,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  child: TextField(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: colorDarkGrey, letterSpacing: 1),
                    onChanged: (value) {
                      widget.callback(value);
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15.0),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        hintText: LocaleKeys.search_for_deals.tr(),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(
                            color: colorDarkGrey,
                          fontSize: context.locale == Locale('ru') ? 12 : 14,
                          letterSpacing: context.locale == Locale('ru') ? 1 : 2,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                const BorderSide(color: colorDarkGrey))),
                  ),
                ),
              )
            ]))
      ],
    );
  }
}
