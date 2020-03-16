import 'package:katsutoshii/config/projects.dart';
import 'package:katsutoshii/widgets/geobackground.dart';
import 'package:katsutoshii/widgets/project.dart';
import 'package:katsutoshii/widgets/responsive.dart';
import 'package:flutter/material.dart';

class ProjectsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return withGeometricBackground(
        ResponsiveWidget(
          largeScreen: GridView.count(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height * 0.9),
            children: List.generate(
                projects.length, (index) => ProjectWidget(projects[index], 0)),
          ),
          smallScreen: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) => ProjectWidget(
                  projects[index], (index == projects.length - 1 ? 16.0 : 0))),
        ),
        context);
  }
}
