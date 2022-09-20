


// model & url,
// class T
import 'package:socail/modules/comment/models/comment.dart';

import '../../../providers/api_provider.dart';

class ListCommentsRepo {
  final apiProvider = ApiProvider();
  final String postId;

  ListCommentsRepo(this.postId);

  Future<List<Comment>?> getComments() async {
    try {
      final res = await apiProvider.get("/posts/$postId/comments");

      if (res.statusCode != 200) {
        return null;
      }

      List data = res.data['data'];

      return data.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}