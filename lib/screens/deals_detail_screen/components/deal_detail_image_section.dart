import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/repository/deals_repository.dart';

import '../../../models/deal.dart';
import '../../../models/image_path.dart';
import '../../../styles/style_exports.dart';
import '../deals_detail_screen.dart';

class DealDetailImageSection extends StatefulWidget {
  const DealDetailImageSection({
    Key? key,
  }) : super(key: key);

  @override
  State<DealDetailImageSection> createState() => _DealDetailImageSectionState();
}

class _DealDetailImageSectionState extends State<DealDetailImageSection> {
  final DealsRepository dealsRepository = DealsRepository();
  List<DealImage> imagePaths = <DealImage>[];
  FutureOr<void> _onFetchImagePaths(int dealId) async {
    List<DealImage> imagePath = await dealsRepository.getImagePath(dealId);
    setState(() {
      imagePaths = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    Deal currentDeal = InheritedDealsDetailScreen.of(context).currentDeal;
    _onFetchImagePaths(currentDeal.id!);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: BlocBuilder<DealsBloc, DealsState>(
        builder: (context, state) {
          print('deals_detail ${imagePaths}');
          return imagePaths.isNotEmpty ?
          CarouselSlider.builder(
              itemCount: imagePaths.length,
              itemBuilder: (BuildContext context, int itemIndex,
                  int pageViewIndex) => ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                                File(imagePaths[itemIndex].imagePath!),
                                fit: BoxFit.cover)),
              options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                autoPlay: false,
              )) :
          SvgPicture.asset(noDataImage, fit: BoxFit.cover);
        },
      ),
    );
  }
}