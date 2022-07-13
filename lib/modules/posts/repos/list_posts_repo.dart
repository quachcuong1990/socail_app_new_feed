import 'package:dio/dio.dart';
import '../../../providers/api_provider.dart';
import '../../../src/day05/models/public.dart';
import '../models/post.dart';


class ListPostsRepo {
  final apiProvider = ApiProvider();

  Future<List<Post>?> getPosts() async {
    try {
      final res = await apiProvider.get("/posts");

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
