import 'package:flutter/foundation.dart';

enum Nav {Website, Manual}

class BottomNavController extends ChangeNotifier {

    Nav _selected = Nav.Website;

    Nav getSelectedNavItem(){
      return _selected;
    }

    void setSelectedNavItem(Nav nav){
        _selected = nav;
        notifyListeners();
    }

}