import 'package:flutter/material.dart';
import 'package:katsutoshii/config/assets.dart';
import 'package:katsutoshii/config/constants.dart';
import 'package:katsutoshii/utils/url.dart';
import 'package:katsutoshii/widgets/geobackground.dart';

Widget mainScrollView(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 80,
              backgroundImage: Image.asset(Assets.avatar).image,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              Constants.name,
              textScaleFactor: 4,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              Constants.interests,
              style: Theme.of(context).textTheme.caption,
              textScaleFactor: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Constants.github.toWidget(),
                Constants.twitter.toWidget(),
                Constants.soundcloud.toWidget(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Constants.facebook.toWidget(),
                Constants.instagram.toWidget(),
                Constants.linkedin.toWidget(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton.icon(
                icon: SizedBox(
                    width: 40, height: 20, child: Icon(Icons.file_download)),
                label: Text('Resume'),
                onPressed: () => launchURL(Constants.resumeDownload))
          ],
        ),
      ),
    ),
  );
}

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return withGeometricBackground(mainScrollView(context), context);
  }
}
