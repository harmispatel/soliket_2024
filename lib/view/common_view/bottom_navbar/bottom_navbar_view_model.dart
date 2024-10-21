import 'package:flutter/cupertino.dart';

class BottomNavbarViewModel with ChangeNotifier {
  late BuildContext context;
  int selectedIndex = 0;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void onMenuTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
