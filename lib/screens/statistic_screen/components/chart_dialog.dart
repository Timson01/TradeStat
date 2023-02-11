import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/screens/charts/named_income_chart_screen.dart';
import 'package:trade_stat/screens/charts/percentage_chart_screen.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../models/charts_model.dart';
import '../../../styles/style_exports.dart';

class ChartDialog extends StatefulWidget {
  final int index;

  const ChartDialog({Key? key, required this.index}) : super(key: key);

  @override
  State<ChartDialog> createState() => _ChartDialogState();
}

class _ChartDialogState extends State<ChartDialog> {
  var currentSelectedValueHashtag = '';
  bool haveSearch = false;
  bool hashtag = false;
  bool doItOnce = false;
  var currentSelectedValuePosition = LocaleKeys.all.tr();
  List<String> position = <String>['Long', LocaleKeys.all.tr(), 'Short'];
  String id = '';
  String title = '';
  final _controller = TextEditingController();
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  List<String> hashtags = [];

  InterstitialAd? interstitialAd;
  bool isLoaded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad){
              interstitialAd = ad;
              _setFullScreenCallback(ad);
            },
            onAdFailedToLoad: (err){
              debugPrint(err.message);
            }
        )
    );
  }

  void _setFullScreenCallback (InterstitialAd ad){
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('$ad onAdShowedFullScreenContent'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: ( InterstitialAd ad, AdError error ) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
      },
      onAdImpression: (InterstitialAd ad) => print('$ad Impression occurred'),
    );
  }

  void _showInterstitialAd(){
    interstitialAd!.show();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    switch (widget.index) {
      case 0:
        id = NamedIncomeChartScreen.id;
        title = LocaleKeys.income_chart.tr();
        break;
      case 1:
        id = NamedIncomeChartScreen.id;
        hashtag = true;
        haveSearch = true;
        title = LocaleKeys.hashtag_income_chart.tr();
        break;
      case 2:
        id = NamedIncomeChartScreen.id;
        haveSearch = true;
        title = LocaleKeys.ticker_symbol_income_chart.tr();
        break;
      case 3:
        id = PercentageChartScreen.id;
        title = LocaleKeys.percentage_of_positive_and_negative_deals.tr();
        break;
      case 4:
        id = PercentageChartScreen.id;
        hashtag = true;
        haveSearch = true;
        title = LocaleKeys.percentage_of_positive_and_negative_deals_by_hashtag.tr();
        break;
      case 5:
        id = PercentageChartScreen.id;
        haveSearch = true;
        title = LocaleKeys.percentage_of_positive_and_negative_deals_by_ticker_symbol.tr();
        break;
    }

    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5?.copyWith(
              letterSpacing: 0,
              fontSize: 18,
            ),
      ),
      content: Container(
        constraints: BoxConstraints(
          minHeight: height * 0.2,
          maxHeight: height * 0.3,
        ),
        width: width * 0.8,
        child: SingleChildScrollView(
          child: BlocBuilder<DealsBloc, DealsState>(
            builder: (context, state) {
              if (state.deals.isNotEmpty) {
                if (!doItOnce) {
                  if(state.hashtags.length >= 3){
                    hashtags.addAll(state.hashtags);
                    hashtags.removeAt(0);
                  }
                  hashtags.isNotEmpty ? currentSelectedValueHashtag = hashtags[1] : '';
                  dateTimeRange = DateTimeRange(
                      start: DateTime.fromMillisecondsSinceEpoch(
                          state.deals[state.deals.length - 1].dateCreated),
                      end: DateTime.fromMillisecondsSinceEpoch(
                          state.deals[0].dateCreated));
                  doItOnce = !doItOnce;
                }
              }
              return Column(
                mainAxisAlignment: haveSearch
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  // ------------ Search Section -----------

                  haveSearch
                      ? Column(
                          children: [
                            SizedBox(height: height * 0.02),
                            Text(
                              hashtag ? LocaleKeys.hashtag.tr() : LocaleKeys.ticker_symbol.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      fontSize: 15,
                                      color: colorDarkGrey,
                                      letterSpacing: 1),
                            ),
                            SizedBox(height: height * 0.015),
                            hashtag
                                ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 7, right: 7),
                                        child: DropdownButton<String>(
                                          menuMaxHeight: height * 0.2,
                                          isExpanded: true,
                                          isDense: true,
                                          value: hashtags.isNotEmpty ? currentSelectedValueHashtag : null,
                                          items: hashtags
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(value,
                                                                  style: Theme
                                                                          .of(
                                                                              context)
                                                                      .textTheme
                                                                      .subtitle2
                                                                      ?.copyWith(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              colorDarkGrey,
                                                                          letterSpacing:
                                                                              1)),
                                                              const Icon(
                                                                  Icons
                                                                      .grid_3x3_rounded,
                                                                  color:
                                                                      colorDarkGrey,
                                                                  size: 16)
                                                            ]),
                                                      ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState((){
                                              currentSelectedValueHashtag = value!;
                                            });
                                          },
                                        ),
                                      )
                                : TextField(
                                    controller: _controller,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            fontSize: 12,
                                            color: colorDarkGrey,
                                            letterSpacing: 1),
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: colorDarkGrey)),
                                        hintText: hashtag
                                            ? LocaleKeys.enter_hashtag.tr()
                                            : LocaleKeys.enter_ticker_symbol.tr(),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                                fontSize: 12,
                                                color: colorDarkGrey,
                                                letterSpacing: 1)),
                                  ),
                            SizedBox(height: height * 0.02),
                          ],
                        )
                      : SizedBox(height: height * 0.02),

                  // ------------ Date Section -----------

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.date.tr(),
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 15,
                            color: colorDarkGrey,
                            letterSpacing: 1),
                      ),
                      SizedBox(height: height * 0.015),
                      InkWell(
                        onTap: () async {
                          DateTimeRange? newDateRange =
                              await showDateRangePicker(
                                  context: context,
                                  initialDateRange: dateTimeRange,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2030),
                                  builder:
                                      (BuildContext? context, Widget? child) {
                                    return FittedBox(
                                      child: Theme(
                                        data: ThemeData(
                                          primaryColor: colorBlue,
                                        ),
                                        child: child!,
                                      ),
                                    );
                                  });

                          if (newDateRange != null) {
                            setState(() {
                              dateTimeRange = newDateRange;
                              context.read<DealsBloc>().add(FetchDealsWithDate(
                                startDate: dateTimeRange.start.millisecondsSinceEpoch,
                                endDate: dateTimeRange.end.millisecondsSinceEpoch,
                              ));
                            });
                          }
                        },
                        child: Text(
                          '${DateFormat('yyyy/MM/dd').format(dateTimeRange.start)} - '
                          '${DateFormat('yyyy/MM/dd').format(dateTimeRange.end)}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  fontSize: 14,
                                  color: colorMidnightBlue,
                                  letterSpacing: 1),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.02),

                  // ------------ Position Section -----------

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.position.tr(),
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 15,
                            color: colorDarkGrey,
                            letterSpacing: 1),
                      ),
                      SizedBox(height: height * 0.015),
                      Padding(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          value: currentSelectedValuePosition,
                          items: position
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.copyWith(
                                                    fontSize: 14,
                                                    color: colorMidnightBlue,
                                                    letterSpacing: 1)),
                                      ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              currentSelectedValuePosition = newValue!;
                              if(currentSelectedValuePosition != LocaleKeys.all.tr()){
                                context.read<DealsBloc>().add(FetchDealsByPosition(
                                    startDate: dateTimeRange.start.millisecondsSinceEpoch,
                                    endDate: dateTimeRange.end.millisecondsSinceEpoch,
                                    position: currentSelectedValuePosition
                                ));
                              }
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),

      // ------------ Buttons Section -----------

      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                LocaleKeys.cancel.tr(),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorMidnightBlue, letterSpacing: 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                LocaleKeys.confirm.tr(),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorMidnightBlue, letterSpacing: 1),
              ),
              onPressed: () {
                _showInterstitialAd();
                Navigator.of(context).pushReplacementNamed(id,
                    arguments: ChartsModel(
                        name: hashtag ? currentSelectedValueHashtag : _controller.text,
                        hashtag: hashtag,
                        position: currentSelectedValuePosition,
                        dateTimeRange: dateTimeRange));
              },
            ),
          ],
        )
      ],
    );
  }
}

