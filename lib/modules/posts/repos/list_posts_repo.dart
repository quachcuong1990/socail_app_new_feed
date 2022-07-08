import 'package:dio/dio.dart';
import '../../../src/day05/models/public.dart';
import '../models/post.dart';


class ListPostsRepo {
  Future<List<Post>?> getPosts() async {
    try {
      final res = await Dio(BaseOptions(
              baseUrl: 'https://api.dofhunt.200lab.io', connectTimeout: 3000))
          .get(
        "/v1/posts",
        queryParameters: {'tags': "portrait"},
        options: Options(method: 'get', headers: {
          'Authorization': "Bearer " + userToken,
          "Content-Type": "application/json"
        }),
      );

      if (res.statusCode != 200) {
        return null;
      }

      List data = res.data['data'];

      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
