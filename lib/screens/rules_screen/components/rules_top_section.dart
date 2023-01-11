import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../styles/style_exports.dart';

typedef void StringCallback(String userSearchInput);

class RulesTopSection extends StatefulWidget {
  final StringCallback callback;

  const RulesTopSection({Key? key, required this.callback}) : super(key: key);

  @override
  State<RulesTopSection> createState() => _RulesTopSectionState();
}

class _RulesTopSectionState extends State<RulesTopSection> {
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
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 22, color: Colors.white)),
                  Text(
                    "My Rules",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white,
                      fontSize: 24
                        ),
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(Icons.add,
                          size: 27, color: Colors.white)),
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
                        contentPadding: EdgeInsets.only(left: 15.0),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                        hintText: 'Search for rules',
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
