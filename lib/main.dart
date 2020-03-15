import 'package:flutter/material.dart';
import 'package:katsutoshii/config/constants.dart';
import 'package:katsutoshii/models/theme_switcher.dart';
import 'package:katsutoshii/pages/home.dart';
import 'package:scoped_model/scoped_model.dart';

import 'config/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Katsutoshii();
  }
}

class Katsutoshii extends StatelessWidget {
  const Katsutoshii({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeSwitcher>(
      child: ScopedModelDescendant<ThemeSwitcher>(
        builder: (context, child, model) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.name,
          theme: model.isDarkMode ? darkTheme(context) : lightTheme(context),
          home: HomePage(),
        ),
      ),
      model: ThemeSwitcher(),
    );
  }
}
