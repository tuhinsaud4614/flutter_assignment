import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Map<String, String> textPair;
  CustomText({@required this.textPair});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text.rich(

        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: "${textPair.keys.first}: ",
            ),
            TextSpan(text: "${textPair.values.first}"),
          ],
        ),
      ),
    );
  }
}
