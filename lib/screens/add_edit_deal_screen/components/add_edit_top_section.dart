import 'package:flutter/material.dart';
import '../../deals_screen/deals_screen.dart';
import '../add_deal_screen.dart';

class AddEditTopSection extends StatefulWidget {
  final String id;
  const AddEditTopSection({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  State<AddEditTopSection> createState() => _AddEditTopSectionState();
}

class _AddEditTopSectionState extends State<AddEditTopSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 22, color: Colors.white),
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(DealsScreen.id)
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.id == AddDealScreen.id ? 'Create new deal' : 'Edit deal',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.right,
            ),
            Text(
              'It\'s simple',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontSize: 22, color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ],
        )
      ],
    );
  }
}
