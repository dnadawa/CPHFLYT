import 'package:flutter/foundation.dart';

enum Nav {Website, Manual}

class BottomNavController extends ChangeNotifier {

    Nav _selected = Nav.Website;
    Nav? _dropDown;

    Nav get navItem{
      return _selected;
    }

    set navItem(Nav nav){
        _selected = nav;
        notifyListeners();
    }

    Nav? get dropDownValue{
        return _dropDown;
    }

    set dropDownValue(Nav? nav){
        _dropDown = nav;
        notifyListeners();
    }

}