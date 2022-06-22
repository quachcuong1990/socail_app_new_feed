
import 'package:rxdart/rxdart.dart';
import '../../../providers/bloc_provider.dart';
import '../models/post.dart';
import '../repos/list_posts_repo.dart';

class ListPostsRxDartBloc extends BlocBase{
  final _postsCtrl = BehaviorSubject<List<Post>?>.seeded(const []);
  Stream<List<Post>?> get postsStream => _postsCtrl.stream;

  Future<void> getPosts() async {
    try {
      final res = await ListPostsRepo().getPosts();
      if (res != null) {
        _postsCtrl.sink.add(res);
      }
    } catch (e) {
      _postsCtrl.sink.addError('Cannot fetch list posts right now!!!');
    }
  }

  @override
  void dispose() {
    _postsCtrl.close();
  }
}