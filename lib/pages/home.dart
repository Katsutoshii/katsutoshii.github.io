import 'package:flutter/material.dart';
import 'package:katsutoshii/config/assets.dart';
import 'package:katsutoshii/tabs/about.dart';
import 'package:katsutoshii/models/theme_switcher.dart';
import 'package:katsutoshii/tabs/particles.dart';
import 'package:katsutoshii/tabs/projects.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/responsive.dart';

class HomePage extends StatelessWidget {
  Widget themeSwitch(BuildContext context) {
    return IconButton(
      icon: ScopedModel.of<ThemeSwitcher>(context).isDarkMode
          ? Icon(Icons.wb_sunny)
          : Image.asset(
              Assets.moon,
              height: 20,
              width: 20,
            ),
      onPressed: () =>
          ScopedModel.of<ThemeSwitcher>(context).switchDarkMode(),
    );
  }

  Widget tabScaffold(BuildContext context, {bool isLarge: false}) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(fit: BoxFit.fitHeight, child: Text('勝')),
        ),
        actions: <Widget>[themeSwitch(context)],
        title: TabBar(
          tabs: [
            isLarge ? Tab(text: "About") : Tab(icon: Icon(Icons.account_circle)),
            isLarge ? Tab(text: "Music") : Tab(icon: Icon(Icons.graphic_eq)),
            isLarge ? Tab(text: "Projects") : Tab(icon: Icon(Icons.chrome_reader_mode)),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          AboutTab(),
          ParticlesTab(),
          ProjectsTab(),
        ],
      ),
    );
  }

  Widget tabController(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: ResponsiveWidget(
          largeScreen: tabScaffold(context, isLarge: true),
          smallScreen: tabScaffold(context, isLarge: false)
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return tabController(context);
  }
}
