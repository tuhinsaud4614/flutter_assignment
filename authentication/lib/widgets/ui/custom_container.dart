import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  CustomContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(color: Theme.of(context).primaryColor),
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: <BoxShadow> [
          BoxShadow(
            offset: Offset(-12.0, -12.0),
            blurRadius: 12.0,
            spreadRadius: 0.0,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          BoxShadow(
            offset: Offset(12.0, 12.0),
            blurRadius: 12.0,
            spreadRadius: 0.0,
            color: Color.fromRGBO(0, 0, 0, 0.03),
          ),
        ]
      ),
      child: child,
    );
  }
}
