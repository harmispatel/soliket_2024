import 'package:flutter/cupertino.dart';

import '../../services/index.dart';

class CategoryViewModel with ChangeNotifier {
  late BuildContext context;
  final services = Services();
  bool isInitialLoading = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }
}
