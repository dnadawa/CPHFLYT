import 'package:flutter/foundation.dart';

enum Filter {Pending, Approved, Trash}

class FilterController extends ChangeNotifier {

  Filter _selected = Filter.Pending;

  Filter get filter{
    return _selected;
  }

  set filter(Filter filter){
    _selected = filter;
    notifyListeners();
  }

}