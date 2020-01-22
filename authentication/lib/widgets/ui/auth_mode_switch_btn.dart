import 'package:flutter/material.dart';

class AuthModeSwitchBtn extends StatelessWidget {
  final String title;
  final Function onPressed;
  AuthModeSwitchBtn({@required this.title, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
