import 'package:flutter/material.dart';

import '../../../styles/style_exports.dart';

class EditSection extends StatefulWidget {
  const EditSection({
    Key? key,
  }) : super(key: key);

  @override
  State<EditSection> createState() => _EditSectionState();
}

class _EditSectionState extends State<EditSection> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        // ---- Ticker Name -------
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Ticker Name',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.black
                )
            ),
            SizedBox(height: height * 0.01),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 1,
                          color: colorDarkGrey
                      )
                  ),
                  hintText: 'Enter ticker name',
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      color: colorDarkGrey,
                      letterSpacing: 1
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        // ------- Description -------
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Description',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.black
                )
            ),
            SizedBox(height: height * 0.01),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 1,
                          color: colorDarkGrey
                      )
                  ),
                  hintText: 'Enter description for a deal',
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      color: colorDarkGrey,
                      letterSpacing: 1
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        // ------- Date -------
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Date',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.black
                )
            ),
            SizedBox(height: height * 0.01),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 1,
                        color: colorDarkGrey
                    ),
                  ),
                  suffixIcon: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: const Icon(Icons.date_range_outlined, size: 20, color: colorDarkGrey)
                  ),
                  suffixIconConstraints: BoxConstraints( maxHeight: 20),
                  hintText: '12.10.22',
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      color: colorDarkGrey,
                      letterSpacing: 1
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        // ------- Hashtag -------
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Hashtag',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.black
                )
            ),
            SizedBox(height: height * 0.01),
            TextField(
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 1,
                        color: colorDarkGrey
                    ),
                  ),
                  hintText: 'Add a hashtag to group deals',
                  hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      color: colorDarkGrey,
                      letterSpacing: 1
                  )
              ),
            ),
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
                  Text(
                      'Amount of deal',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.black
                      )
                  ),
                  SizedBox(height: height * 0.01),
                  TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 1,
                              color: colorDarkGrey
                          ),
                        ),
                        hintText: '---',
                        hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 12,
                            color: colorDarkGrey,
                            letterSpacing: 1
                        )
                    ),
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
                  Text(
                      'Number of stocks',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.black
                      )
                  ),
                  SizedBox(height: height * 0.01),
                  TextField(
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 1,
                              color: colorDarkGrey
                          ),
                        ),
                        hintText: '---',
                        hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontSize: 12,
                            color: colorDarkGrey,
                            letterSpacing: 1
                        )
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
                  backgroundColor: MaterialStateProperty.all<Color>(colorBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )
              ),
              onPressed: (){},
              child: Text('Create',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white,
                      fontSize: 13
                  ))
          ),
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}