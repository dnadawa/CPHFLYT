import 'package:flutter/foundation.dart';

enum Filter {Pending, Approved, Trash}
enum CompletedFilter {All, Completed, NotCompleted}

class FilterController extends ChangeNotifier {

  Filter _selected = Filter.Pending;
  CompletedFilter _completedFilter = CompletedFilter.All;

  Filter get filter{
    return _selected;
  }

  set filter(Filter filter){
    _selected = filter;
    notifyListeners();
  }

  CompletedFilter get completedFilter{
    return _completedFilter;
  }

  set completedFilter(CompletedFilter filter){
    _completedFilter = filter;
    notifyListeners();
  }

}