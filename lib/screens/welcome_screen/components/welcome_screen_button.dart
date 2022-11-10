import 'package:flutter/material.dart';

class WelcomeScreenButton extends StatelessWidget {
  final String title;
  const WelcomeScreenButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Colors.white
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
        child: Text(title,
            style: Theme.of(context).textTheme.subtitle1,
            )),
    );
  }
}