import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/models/deal.dart';
import 'package:trade_stat/models/image_path.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/add_deal_screen.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/edit_deal_screen.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../styles/style_exports.dart';
import '../../deals_screen/deals_screen.dart';
import 'add_edit_deal_methods.dart';

class EditSection extends StatefulWidget {
  final String id;

  const EditSection({Key? key, required this.id}) : super(key: key);

  @override
  State<EditSection> createState() => _EditSectionState();
}

class _EditSectionState extends State<EditSection> with AddEditDealMethods {
  List<String> position = <String>['Long', 'Short'];
  var currentSelectedValueHashtag = LocaleKeys.add_hashtag.tr();
  var currentSelectedValuePosition = 'Long';
  late Deal currentDeal;
  final _tickerNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController(text: '0');
  final _numberOfStocksController = TextEditingController(text: '0');
  final _incomeController = TextEditingController(text: '0');
  bool _tickerNameState = false;
  DateTime _date = DateTime.now();
  bool doItOnce = false;
  late GlobalKey dropdownKey;

  @override
  void initState() {
    dropdownKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _tickerNameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _numberOfStocksController.dispose();
    _incomeController.dispose();
    super.dispose();
  }

  String? get _errorText {
    final text = _tickerNameController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  void _showDatePicker() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: colorBlue, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: colorBlue, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colorBlue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate == null) return;

    setState(() {
      _date = newDate;
    });
  }

  void _dropDownCallback(value) {
    setState(() {
      currentSelectedValueHashtag = value;
    });
    if (value == LocaleKeys.add_hashtag.tr()) {
      showHashtagDialog();
    }
  }

  // WIDGET BUILD ------------
  // WIDGET BUILD ------------
  // WIDGET BUILD ------------

  @override
  Widget build(BuildContext context) {
    if (widget.id == EditDealScreen.id) {
      currentDeal = InheritedEditDealScreen.of(context).currentDeal;
      if (!doItOnce) {
        onFetchImagePaths(currentDeal.id!);
        getHashtags();
        _tickerNameController.text = currentDeal.tickerName;
        _descriptionController.text = currentDeal.description;
        _numberOfStocksController.text = currentDeal.numberOfStocks.toString();
        _amountController.text = currentDeal.amount.toString();
        _incomeController.text = currentDeal.income.toString();
        _date = DateTime.fromMillisecondsSinceEpoch(currentDeal.dateCreated);
        if (currentDeal.hashtag == '' || currentDeal.hashtag.isEmpty) {
          currentSelectedValueHashtag = LocaleKeys.add_hashtag.tr();
        } else {
          currentSelectedValueHashtag = currentDeal.hashtag;
        }
        currentSelectedValuePosition =
            currentDeal.position.isNotEmpty ? currentDeal.position : "Long";
        doItOnce = !doItOnce;
      }
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: BlocBuilder<DealsBloc, DealsState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------ Image Section - start -----------
            imagePaths.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                          itemCount: imagePaths.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                            File(imagePaths[itemIndex]),
                                            width: width * 0.85,
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                      top: 5,
                                      right: 10,
                                      child: SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: FloatingActionButton(
                                          backgroundColor: colorBlue,
                                          onPressed: () => setState(() {
                                            imagePaths
                                                .remove(imagePaths[itemIndex]);
                                          }),
                                          child: const Icon(
                                              size: 18,
                                              color: Colors.white,
                                              Icons.delete_forever_rounded),
                                        ),
                                      ))
                                ],
                              ),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            scrollDirection: Axis.horizontal,
                            autoPlay: false,
                          )),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.03, top: 5),
                        child: InkWell(
                          onTap: () => showSelectPhotoOptions(),
                          child: Text(
                            LocaleKeys.add_photo.tr(),
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: colorBlue,
                                      letterSpacing: 1,
                                    ),
                          ),
                        ),
                      )
                    ],
                  )
                : InkWell(
                    onTap: () {
                      showSelectPhotoOptions();
                    },
                    child: SvgPicture.asset(addPhoto,
                        fit: BoxFit.fitWidth, width: width * 0.85)),
            // ------ Image Section - end -----------
            SizedBox(height: height * 0.02),
            Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Column(
                  children: [
                    // ---- Ticker Name -------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.ticker_symbol.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                color: Colors.black,
                                fontSize: context.locale == Locale('ru') ? 14 : 16
                            )),
                        SizedBox(height: height * 0.01),
                        TextField(
                          controller: _tickerNameController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
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
                              errorText: _tickerNameState ? _errorText : null,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: colorDarkGrey)),
                              hintText: LocaleKeys.enter_ticker_symbol.tr(),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      fontSize: 12,
                                      color: colorDarkGrey,
                                      letterSpacing: 1)),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // ------- Description -------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.description.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                color: Colors.black,
                                fontSize: context.locale == Locale('ru') ? 14 : 16
                            )),
                        SizedBox(height: height * 0.01),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          controller: _descriptionController,
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
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: colorDarkGrey)),
                              hintText: LocaleKeys.enter_description.tr(),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      fontSize: 12,
                                      color: colorDarkGrey,
                                      letterSpacing: 1)),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // ------- Hashtag -------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.hashtag.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                color: Colors.black,
                                fontSize: context.locale == Locale('ru') ? 14 : 16
                            )),
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          child: DropdownButton<String>(
                            menuMaxHeight: height * 0.2,
                            key: dropdownKey,
                            isExpanded: true,
                            isDense: true,
                            value: currentSelectedValueHashtag,
                            items: state.hashtags
                                .map<DropdownMenuItem<String>>((String value) =>
                                    DropdownMenuItem(
                                      value: value,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.copyWith(
                                                        fontSize: 12,
                                                        color: colorDarkGrey,
                                                        letterSpacing: 1)),
                                            value == LocaleKeys.add_hashtag.tr()
                                                ? const Icon(Icons.add,
                                                    color: colorDarkGrey,
                                                    size: 22)
                                                : IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        const BoxConstraints(),
                                                    onPressed: () {
                                                      widget.id ==
                                                              EditDealScreen.id
                                                          ? null
                                                          : showHashtagDeleteDialog(value, currentSelectedValueHashtag);
                                                      currentSelectedValueHashtag = LocaleKeys.add_hashtag.tr();
                                                      /*hashtags.remove(value);
                                                      setHashtag(hashtags);
                                                      context.read<DealsBloc>()
                                                        .add(DeleteHashtag(
                                                            hashtag: value));
                                                      Navigator.pop(context);*/
                                                    },
                                                    icon: Icon(
                                                        widget.id ==
                                                                EditDealScreen
                                                                    .id
                                                            ? Icons
                                                                .grid_3x3_rounded
                                                            : Icons
                                                                .delete_forever_rounded,
                                                        color: colorDarkGrey,
                                                        size: 18),
                                                  )
                                          ]),
                                    ))
                                .toList(),
                            onChanged: _dropDownCallback,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // ------- Position -------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.position.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                color: Colors.black,
                                fontSize: context.locale == Locale('ru') ? 14 : 16
                            )),
                        SizedBox(height: height * 0.01),
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
                                                      fontSize: 12,
                                                      color: value == "Long"
                                                          ? Colors.green
                                                          : Colors.red,
                                                      letterSpacing: 1)),
                                        ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                currentSelectedValuePosition = newValue!;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // ------- Amount of deal and Number of stocks -------
                    Row(
                      children: [
                        // ----- Amount of deal -----------
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.amount_of_deal.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                      color: Colors.black,
                                      fontSize: context.locale == Locale('ru') ? 14 : 16
                                  )),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: _amountController,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: colorDarkGrey,
                                        letterSpacing: 1),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                ],
                                decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1, color: colorDarkGrey),
                                    ),
                                    hintText: '---',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            fontSize: 12,
                                            color: colorDarkGrey,
                                            letterSpacing: 1)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        // ----- Number of stocks -----------
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.number_of_stocks.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                      color: Colors.black,
                                    fontSize: context.locale == Locale('ru') ? 14 : 16
                                  )
                              ),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: _numberOfStocksController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                ],
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1, color: colorDarkGrey),
                                    ),
                                    hintText: '---',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            fontSize: 12,
                                            color: colorDarkGrey,
                                            letterSpacing: 1)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // ----- Income and Date
                    Row(
                      children: [
                        // ----- Income -----------
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.income.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                      color: Colors.black,
                                      fontSize: context.locale == Locale('ru') ? 14 : 16
                                  )),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: _incomeController,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: colorDarkGrey,
                                        letterSpacing: 1),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter(RegExp("[0-9.-]"), allow: true),
                                ],
                                decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1, color: colorDarkGrey),
                                    ),
                                    hintText: '---',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            fontSize: 12,
                                            color: colorDarkGrey,
                                            letterSpacing: 1)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        // ----- Date -----------
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.date.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                      color: Colors.black,
                                      fontSize: context.locale == Locale('ru') ? 14 : 16
                                  )),
                              SizedBox(height: height * 0.01),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: colorDarkGrey),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(DateFormat("dd.MM.yyyy").format(_date),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                                fontSize: 12,
                                                color: colorDarkGrey,
                                                letterSpacing: 1)),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          onTap: () => _showDatePicker(),
                                          child: const Icon(
                                              Icons.date_range_outlined,
                                              size: 18,
                                              color: colorDarkGrey),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // ------- Button  --------
                    SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(colorBlue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              )),
                          onPressed: _tickerNameController.value.text.isNotEmpty
                              ? () async {
                                  int lastId = await getLastId();
                                  if (widget.id == AddDealScreen.id) {
                                    Deal deal = Deal(
                                        tickerName:
                                            _tickerNameController.value.text,
                                        description:
                                            _descriptionController.value.text,
                                        hashtag: currentSelectedValueHashtag ==
                                            LocaleKeys.add_hashtag.tr()
                                            ? ''
                                            : currentSelectedValueHashtag,
                                        position: currentSelectedValuePosition,
                                        dateCreated:
                                            _date.millisecondsSinceEpoch,
                                        amount: double.parse(
                                            _amountController.value.text).abs(),
                                        income: double.parse(
                                            _incomeController.value.text),
                                        numberOfStocks: int.parse(
                                            _numberOfStocksController
                                                .value.text).abs().round());
                                    context
                                        .read<DealsBloc>()
                                        .add(AddDeal(deal: deal));
                                    imagePaths.isEmpty
                                        ? Navigator.of(context)
                                            .pushReplacementNamed(
                                                DealsScreen.id)
                                        : {
                                            imagePaths.forEach((element) {
                                              context.read<DealsBloc>().add(
                                                  AddDealImage(
                                                      imagePath: DealImage(
                                                          imagePath: element,
                                                          deal_id: lastId + 1)));
                                            })
                                          };
                                    Navigator.of(context)
                                        .pushReplacementNamed(DealsScreen.id);
                                  }
                                  if (widget.id == EditDealScreen.id) {
                                    Deal deal = Deal(
                                        id: currentDeal.id,
                                        tickerName:
                                            _tickerNameController.value.text,
                                        description:
                                            _descriptionController.value.text,
                                        hashtag: currentSelectedValueHashtag ==
                                            LocaleKeys.add_hashtag.tr()
                                            ? ''
                                            : currentSelectedValueHashtag,
                                        position: currentSelectedValuePosition,
                                        dateCreated:
                                            _date.millisecondsSinceEpoch,
                                        amount: double.parse(
                                            _amountController.value.text).abs(),
                                        income: double.parse(
                                            _incomeController.value.text),
                                        numberOfStocks: int.parse(
                                            _numberOfStocksController
                                                .value.text).abs().round());
                                    context
                                        .read<DealsBloc>()
                                        .add(UpdateDeal(deal: deal));
                                    for (var element in dealImages) {
                                      context.read<DealsBloc>().add(
                                          DeleteDealImage(id: element.id!));
                                    }
                                    imagePaths.isEmpty
                                        ? Navigator.of(context)
                                            .pushReplacementNamed(
                                                DealsScreen.id)
                                        : {
                                            imagePaths.forEach((element) {
                                              context.read<DealsBloc>().add(
                                                  AddDealImage(
                                                      imagePath: DealImage(
                                                          imagePath: element,
                                                          deal_id:
                                                              currentDeal.id)));
                                            })
                                          };
                                    Navigator.of(context)
                                        .pushReplacementNamed(DealsScreen.id);
                                  }
                                }
                              : () {
                                  setState(() {
                                    _tickerNameState = true;
                                  });
                                  return;
                                },
                          child: Text(
                              widget.id == AddDealScreen.id ? LocaleKeys.create.tr() : LocaleKeys.edit.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: Colors.white, fontSize: 13))),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ))
          ],
        );
      }),
    );
  }
}
