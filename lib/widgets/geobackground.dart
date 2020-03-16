import 'package:flutter/material.dart';

Widget withGeometricBackground(Widget widget, BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return ClipRect(
      child: Stack(children: <Widget>[
    Transform.rotate(
        angle: -0.5,
        child: Transform.translate(
            offset: Offset(width * -0.2, height * -0.36),
            child: Container(
                width: width,
                height: height * 0.5,
                color: Theme.of(context).accentColor.withAlpha(25)))),
    Transform.rotate(
        angle: -0.5,
        child: Transform.translate(
            offset: Offset(width * 0.8, height * -0.36),
            child: Container(
                width: width,
                height: height * 0.5,
                color: Theme.of(context).accentColor.withAlpha(25)))),

    Transform.rotate(
        angle: 0.7,
        child: Transform.translate(
            offset: Offset(width * -0.2, height * -0.8),
            child: Container(
                width: width,
                height: height * 1,
                color: Theme.of(context).accentColor.withAlpha(25)))),
    Transform.rotate(
        angle: 0.7,
        child: Transform.translate(
            offset: Offset(width * 0.8, height * -0.8),
            child: Container(
                width: width,
                height: height * 1,
                color: Theme.of(context).accentColor.withAlpha(25)))),
    widget
  ]));
}
