
import '../../../providers/api_provider.dart';

class CreatePostRepo {
  final _apiProvider = ApiProvider();

  Future<bool> postData(dynamic data) async {
    try{
      final res = await _apiProvider.post('/v1/posts', data: data);

      return res.statusCode == 200;
    }catch(e){
      return false;
    }
  }
}