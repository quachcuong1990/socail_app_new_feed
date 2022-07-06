import 'package:dio/dio.dart';
import '../models/categories.dart';
import '../models/category.dart';
class ListCategoriesRepo{
  Future<List<Categories>?> getCategories()async{
    try{
      final res = await Dio(BaseOptions(baseUrl: 'https://api.dofhunt.200lab.io',connectTimeout: 3000))
          .get('/v1/explore-categories');
      if(res.statusCode != 200){
        return null;
      }
      List data = res.data['data'];
      print('data : ${data}');
      return data.map((json) => Categories.fromJson(json)).toList();
      

    }catch(e){
      rethrow;

    }
  }
}