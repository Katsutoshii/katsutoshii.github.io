import 'package:katsutoshii/config/assets.dart';
import 'package:katsutoshii/models/social.dart';

class Constants {
  static const String name = 'Josiah Putman';
  static const String username = 'Katsutoshii';
  static const String email = 'joshikatsu@gmail.com';
  static const String interests = 'Algorithms. Robotics. Theory. Music. 日本語.';
  static const String resumeDownload =
      'https://docs.google.com/document/d/1raskvhH6GUikREupcn3zDcL0gaJm3DbwYPQPZGoPw8I/export?format=pdf';

  static const SocialMediaIcon facebook = SocialMediaIcon('Facebook',
      Assets.facebook, 'https://www.facebook.com/Josiah.Katsutoshi');
  static const SocialMediaIcon twitter = SocialMediaIcon(
      'Twitter', Assets.twitter, 'https://twitter.com/joshikatsu');
  static const SocialMediaIcon instagram = SocialMediaIcon(
      'Instagram', Assets.instagram, 'https://www.instagram.com/kaatsutoshi/');
  static const SocialMediaIcon soundcloud = SocialMediaIcon(
      'Soundcloud', Assets.soundcloud, 'https://soundcloud.com/josiah-putman/');
  static const SocialMediaIcon linkedin = SocialMediaIcon('LinkedIn',
      Assets.linkedin, 'https://www.linkedin.com/in/josiah-putman-77b25a127/');
  static const SocialMediaIcon github = SocialMediaIcon(
      'GitHub', Assets.github, 'https://github.com/katsutoshii/');
}
