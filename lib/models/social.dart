import 'package:flutter/material.dart';
import 'package:katsutoshii/utils/url.dart';

class SocialMediaIcon {
  final String name;
  final String iconPath;
  final String profileLink;

  const SocialMediaIcon(String name, String iconPath, String profileLink) : 
    name = name, iconPath = iconPath, profileLink = profileLink;

  Widget toWidget() {
    return FlatButton.icon(
      icon: SizedBox(
          width: 20, height: 20, child: Image.asset(this.iconPath)),
      label: Text(this.name),
      onPressed: () => launchURL(this.profileLink)
    );
  }
}
