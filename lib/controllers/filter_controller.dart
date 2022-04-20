import 'package:flutter/foundation.dart';

enum Filter {Pending, Approved, Trash}

class FilterController extends ChangeNotifier {

  Filter _selected = Filter.Pending;

  Filter getFilter(){
    return _selected;
  }

  void setFilter(Filter filter){
    _selected = filter;
    notifyListeners();
  }

}