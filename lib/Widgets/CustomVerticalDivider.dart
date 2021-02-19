import 'package:flutter/widgets.dart';

class CustomVerticalDivider extends StatelessWidget {
  final Color color;
  final double height;

  CustomVerticalDivider({this.color, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: 1,
      height: height,
      color: color,
    );
  }
}
