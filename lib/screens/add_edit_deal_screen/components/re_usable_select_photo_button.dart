import 'package:flutter/material.dart';
import 'package:trade_stat/styles/app_colors.dart';

class SelectPhoto extends StatelessWidget {
  final String textLabel;
  final IconData icon;

  final void Function()? onTap;

  const SelectPhoto({
    Key? key,
    required this.textLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: Colors.grey.shade200,
        maximumSize: Size(width * 0.85, 40),
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              icon,
              color: colorDarkGrey,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              textLabel,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
