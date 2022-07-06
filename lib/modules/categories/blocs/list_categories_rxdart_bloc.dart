
import 'package:rxdart/rxdart.dart';
import 'package:socail/modules/categories/models/categories.dart';
import 'package:socail/modules/categories/repository/list_categories_repo.dart';

import '../../../providers/bloc_provider.dart';
import '../models/category.dart';

class ListCategoriesRxDartBloc extends BlocBase{
  final _categoriesCtrl = BehaviorSubject<List<Categories>?>.seeded(const []);
  Stream<List<Categories>?> get categoriesStream => _categoriesCtrl.stream;
  Future<void> getCategories()async{
    try{
      final res =await ListCategoriesRepo().getCategories();
      if(res!=null){
        _categoriesCtrl.sink.add(res);
      }
    }catch(e){
      _categoriesCtrl.sink.addError('Can not get data');
    }
  }

  @override
  void dispose() {
    _categoriesCtrl.close();
  }

}