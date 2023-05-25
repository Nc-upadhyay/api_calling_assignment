import 'package:flutter/widgets.dart';

import 'data_model.dart';

class DataProvider extends ChangeNotifier
{
  List<DataModel> current=[];
  int pageNumber=1;

  void currentListModify(List<DataModel>list)
  {
    current=list;
    notifyListeners();
  }

}