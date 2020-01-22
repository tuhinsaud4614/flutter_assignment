import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onPressed;
  CustomBtn({
    @required this.title,
    @required this.iconData,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
      label: FittedBox(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
