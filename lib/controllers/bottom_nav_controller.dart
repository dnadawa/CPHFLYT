import 'package:flutter/foundation.dart';

enum Nav {Website, Manual}

class BottomNavController extends ChangeNotifier {

    Nav _selected = Nav.Website;

    Nav get navItem{
      return _selected;
    }

    set navItem(Nav nav){
        _selected = nav;
        notifyListeners();
    }

}