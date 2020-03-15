import 'package:scoped_model/scoped_model.dart';

class ThemeSwitcher extends Model {
  bool isDarkMode = false;

  void switchDarkMode() {
    this.isDarkMode = !this.isDarkMode;
    notifyListeners();
  }
}
