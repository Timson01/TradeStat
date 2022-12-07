import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../styles/style_exports.dart';

class DealsTopSection extends StatefulWidget {
  const DealsTopSection({
    Key? key,
  }) : super(key: key);

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
                  SvgPicture.asset(
                    burgerMenuIcon,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Deals",
                    style:
                    Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(moreMenuIcon,
                      height: 20, fit: BoxFit.cover),
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
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.0),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        hintText: 'Search for deals',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: colorDarkGrey),
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