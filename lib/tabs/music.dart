import 'package:flutter/material.dart';
import 'package:katsutoshii/widgets/geobackground.dart';

class MusicTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return withGeometricBackground(
        Align(
            alignment: Alignment.center,
            child: Text(
              "Coming soon...",
              style: Theme.of(context).textTheme.headline5,
            )),
        context);
  }
}
