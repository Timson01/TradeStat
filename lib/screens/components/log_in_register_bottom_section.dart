import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class LogInRegisterBottomSection extends StatelessWidget {
  const LogInRegisterBottomSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Create',
              style: Theme.of(context).textTheme.headlineMedium,

            ),
            Container(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: colorBlue,
                onPressed: (){},
                child: const Icon(
                    size: 18,
                    color: Colors.white,
                    Icons.arrow_forward_ios
                ),
              ),
            )
          ],
        ),
        SizedBox(height: height*0.06),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: colorDarkGrey
              ),
            ),
            SizedBox(width: 5),
            Text(
              'Log In',
              style: TextStyle(
                color: colorBlue,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),
          ],
        )
      ],
    );
  }
}