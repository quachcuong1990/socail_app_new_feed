import 'package:dio/dio.dart';
import 'package:socail/modules/categories/models/categories.dart';

class ListCategoriesRepo{
  Future<List<Categories>?> getCategoriesData()async{
    try{
      // final res = await Dio(BaseOptions(baseUrl: 'https://ku8989.net/api',connectTimeout: 3000))
      //     .get('/get_data1.php?id=30');
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