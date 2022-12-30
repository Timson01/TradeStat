import 'package:flutter/material.dart';

class AddEditTopSection extends StatelessWidget {
  const AddEditTopSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 25, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Create new deal',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: 24,
                  color: Colors.white
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              'It\'s simple',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: 22,
                  color: Colors.white
              ),
              textAlign: TextAlign.right,
            ),
          ],
        )
      ],
    );
  }
}
