import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/models/deal.dart';
import 'package:trade_stat/models/image_path.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/add_deal_screen.dart';
import 'package:trade_stat/screens/add_edit_deal_screen/edit_deal_screen.dart';
import 'package:trade_stat/screens/deals_screen/deals_screen.dart';

import '../../../repository/deals_repository.dart';
import '../../../styles/style_exports.dart';
import 'select_photo_options_screen.dart';

class EditSection extends StatefulWidget {
  final String id;

  const EditSection({Key? key, required this.id}) : super(key: key);

  @override
  State<EditSection> createState() => _EditSectionState();
}

class _EditSectionState extends State<EditSection> {
  List<String> _imagePaths = [];
  var currentSelectedValueHashtag;
  late Deal currentDeal;
  final _tickerNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _numberOfStocksController = TextEditingController();
  final _hashtagController = TextEditingController();
  bool _tickerNameState = false;
  DateTime _date = DateTime.now();
  bool doItOnce = false;
  final DealsRepository dealsRepository = DealsRepository();
  List<DealImage> imagePaths = <DealImage>[];

  FutureOr<void> _onFetchImagePaths(int dealId) async {
    List<DealImage> imagePath = await dealsRepository.getImagePath(dealId);
    setState(() {
      imagePaths = imagePath;
      imagePath.forEach((element) {
        _imagePaths.add(element.imagePath!);
      });
    });
  }

  @override
  void dispose() {
    _tickerNameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _numberOfStocksController.dispose();
    _hashtagController.dispose();
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
    if (value == 'Add a new hashtag') {
      _showHashtagDialog();
    }
  }

  void _showHashtagDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add a new hashtag to group deals',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  letterSpacing: 1,
                  fontSize: 18,
                ),
          ),
          content: TextField(
            controller: _hashtagController,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                fontSize: 12, color: colorDarkGrey, letterSpacing: 1),
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: colorDarkGrey),
                ),
                hintText: 'Add a new hashtag',
                hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 12, color: colorDarkGrey, letterSpacing: 1)),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorBlue, letterSpacing: 1),
              ),
              onPressed: () {
                if (_hashtagController.value.text.isNotEmpty) {
                  var hashtag = _hashtagController.value.text;
                  context.read<DealsBloc>().add(AddHashtag(hashtag: hashtag));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        setState(() => _imagePaths = List.from(_imagePaths)..add(image.path));
      } else {
        final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
        if (selectedImages == null) return;
        if (selectedImages.isNotEmpty) {
          final List<String> selectedImagesPaths = [];
          for (var element in selectedImages) {
            selectedImagesPaths.add(element.path);
          }
          setState(() => _imagePaths = List.from(_imagePaths)
            ..addAll(selectedImagesPaths));
        }
      }
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: pickImage,
              ),
            );
          }),
    );
  }

  // WIDGET BUILD ------------
  // WIDGET BUILD ------------
  // WIDGET BUILD ------------

  @override
  Widget build(BuildContext context) {
    if (widget.id == EditDealScreen.id) {
      currentDeal = InheritedEditDealScreen.of(context).currentDeal;
      if (!doItOnce) {
        _onFetchImagePaths(currentDeal.id!);
        _tickerNameController.text = currentDeal.tickerName;
        _descriptionController.text = currentDeal.description;
        _numberOfStocksController.text = currentDeal.numberOfStocks.toString();
        _amountController.text = currentDeal.amount.toString();
        _date = DateTime.fromMillisecondsSinceEpoch(currentDeal.dateCreated);
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
            _imagePaths.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                          itemCount: _imagePaths.length,
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
                                            File(_imagePaths[itemIndex]),
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
                                            _imagePaths
                                                .remove(_imagePaths[itemIndex]);
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
                          onTap: () => showSelectPhotoOptions(context),
                          child: Text(
                            'Add Photo',
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
                      showSelectPhotoOptions(context);
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
                        Text('Ticker Name',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black)),
                        SizedBox(height: height * 0.01),
                        TextField(
                          controller: _tickerNameController,
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
                              hintText: 'Enter ticker name',
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
                        Text('Description',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black)),
                        SizedBox(height: height * 0.01),
                        TextField(
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
                              hintText: 'Enter description for a deal',
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
                    // ------- Date -------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black)),
                        SizedBox(height: height * 0.01),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: colorDarkGrey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  margin: const EdgeInsets.only(right: 10),
                                  child: InkWell(
                                    onTap: () => _showDatePicker(),
                                    child: const Icon(Icons.date_range_outlined,
                                        size: 18, color: colorDarkGrey),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    // ------- Hashtag -------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hashtag',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black)),
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          child: DropdownButton<String>(
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
                                            value == "Add a new hashtag"
                                                ? const Icon(Icons.add,
                                                    color: colorDarkGrey,
                                                    size: 22)
                                                : IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                    onPressed: () {
                                                      context.read<DealsBloc>()
                                                        ..add(DeleteHashtag(
                                                            hashtag: value));
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                        Icons
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
                    // ------- Amount of deal and Number of stocks -------
                    Row(
                      children: [
                        // ----- Amount of deal -----------
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Amount of deal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(color: Colors.black)),
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
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
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
                              Text('Number of stocks',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(color: Colors.black)),
                              SizedBox(height: height * 0.01),
                              TextField(
                                controller: _numberOfStocksController,
                                keyboardType: TextInputType.number,
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
                              ? () {
                                  if (widget.id == AddDealScreen.id) {
                                    Deal deal = Deal(
                                        tickerName:
                                            _tickerNameController.value.text,
                                        description:
                                            _descriptionController.value.text,
                                        hashtag: currentSelectedValueHashtag,
                                        dateCreated:
                                            _date.millisecondsSinceEpoch,
                                        amount: double.parse(
                                            _amountController.value.text),
                                        numberOfStocks: int.parse(
                                            _numberOfStocksController
                                                .value.text));
                                    context
                                        .read<DealsBloc>()
                                        .add(AddDeal(deal: deal));
                                    _imagePaths.isEmpty
                                        ? Navigator.of(context)
                                            .pushReplacementNamed(
                                                DealsScreen.id)
                                        : {
                                            _imagePaths.forEach((element) {
                                              context.read<DealsBloc>().add(
                                                  AddDealImage(
                                                      imagePath: DealImage(
                                                          imagePath: element,
                                                          deal_id: state
                                                              .deals.length + 1)));
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      DealsScreen.id);
                                            })
                                          };
                                  }
                                  if (widget.id == EditDealScreen.id) {
                                    Deal deal = Deal(
                                        id: currentDeal.id,
                                        tickerName:
                                            _tickerNameController.value.text,
                                        description:
                                            _descriptionController.value.text,
                                        hashtag: currentSelectedValueHashtag,
                                        dateCreated:
                                            _date.millisecondsSinceEpoch,
                                        amount: double.parse(
                                            _amountController.value.text),
                                        numberOfStocks: int.parse(
                                            _numberOfStocksController
                                                .value.text));
                                    context
                                        .read<DealsBloc>()
                                        .add(UpdateDeal(deal: deal));
                                    imagePaths.forEach((element) {
                                      context.read<DealsBloc>().add(
                                          DeleteDealImage(id: element.id!));
                                    });
                                    _imagePaths.isEmpty
                                        ? Navigator.of(context)
                                            .pushReplacementNamed(
                                                DealsScreen.id)
                                        : {
                                            _imagePaths.forEach((element) {
                                              context.read<DealsBloc>().add(
                                                  AddDealImage(
                                                      imagePath: DealImage(
                                                          imagePath: element,
                                                          deal_id:
                                                              currentDeal.id)));
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      DealsScreen.id);
                                            })
                                          };
                                  }
                                }
                              : () {
                                  setState(() {
                                    _tickerNameState = true;
                                  });
                                  return null;
                                },
                          child: Text(widget.id == AddDealScreen.id ? 'Create': 'Edit',
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
