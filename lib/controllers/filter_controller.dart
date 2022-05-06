import 'package:flutter/foundation.dart';

enum Filter {Pending, Approved, Trash}
enum CompletedFilter {All, Completed, NotCompleted}

class FilterController extends ChangeNotifier {

  Filter _selected = Filter.Pending;
  CompletedFilter _completedFilter = CompletedFilter.All;
  DateTime? _dateFilter;

  Filter get filter => _selected;
  CompletedFilter get completedFilter => _completedFilter;
  DateTime? get dateFilter => _dateFilter;

  set filter(Filter filter){
    _selected = filter;
    notifyListeners();
  }

  set completedFilter(CompletedFilter filter){
    _completedFilter = filter;
    notifyListeners();
  }

  set dateFilter(DateTime? date){
    _dateFilter = date;
    notifyListeners();
  }

}