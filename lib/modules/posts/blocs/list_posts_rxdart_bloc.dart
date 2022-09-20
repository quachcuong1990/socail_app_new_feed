
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:socail/resources/paging_data_bloc.dart';
import 'package:socail/resources/paging_repo.dart';
import '../../../common/blocs/app_event_bloc.dart';
import '../../../providers/bloc_provider.dart';
import '../models/post.dart';
import '../repos/list_post_paging_repo.dart';
import '../repos/list_posts_repo.dart';

// class ListPostsRxDartBloc extends BlocBase{
//   final _postsCtrl = BehaviorSubject<List<Post>?>.seeded(const []);
//   Stream<List<Post>?> get postsStream => _postsCtrl.stream;
//
//   Future<void> getPosts() async {
//     try {
//       final res = await ListPostsRepo().getPosts();
//       if (res != null) {
//         _postsCtrl.sink.add(res);
//       }
//     } catch (e) {
//       _postsCtrl.sink.addError('Cannot fetch list posts right now!!!');
//     }
//   }
//
//   @override
//   void dispose() {
//     _postsCtrl.close();
//   }
// }
class ListPostsRxDartBloc extends PagingDataBehaviorBloc<Post> {
  Stream<List<Post>?> get postsStream => dataStream;

  late final StreamSubscription<BlocEvent> _subDeletePost;
  late final StreamSubscription<BlocEvent> _onLikeAndUnLikePostSub;
  late final StreamSubscription<BlocEvent> _onCreatPostSub;

  final ListPostPagingRepo _repo;

  ListPostsRxDartBloc() : _repo = ListPostPagingRepo() {
    _subDeletePost = AppEventBloc().listenEvent(
      eventName: EventName.deletePost,
      handler: _deletePost,
    );
    _onCreatPostSub = AppEventBloc().listenEvent(
      eventName: EventName.createPost,
      handler: _onCreatePost,
    );

    _onLikeAndUnLikePostSub = AppEventBloc().listenManyEvents(
      listEventName: [
        EventName.likePostDetail,
        EventName.unLikePostDetail,
      ],
      handler: _onLikeAndUnlikePost,
    );
  }
  void _onCreatePost(BlocEvent evt){
     refresh();
  }

  Future<void> getPosts() async {
    return getData();
  }

  void _deletePost(BlocEvent evt) {
    final value = evt.value;
// print('_deletePost $value');
    if (value is String) {
      dataSubject.sink.add(dataValue!.where((e) => e.id != value).toList());
    }
  }

  void _onLikeAndUnlikePost(BlocEvent evt) {
    print('_onLikeAndUnlikePost ${evt.name}');
    final oldPosts = dataValue ?? [];

    final index = oldPosts.indexWhere((p) => p.id == evt.value);

    if(index == -1){
      return;
    }

    final post = oldPosts[index];


    final likeCount = post.likeCounts;
    final eventIsLike = [EventName.likePostDetail].contains(evt.name);
    final likeCountNew = eventIsLike ? likeCount! + 1 : likeCount! - 1;

    post
      ..likeCounts = likeCountNew
      ..liked = eventIsLike;

    oldPosts[index] = post;

    dataSubject.sink.add(oldPosts.toList());
  }

  @override
  void dispose() {
    _subDeletePost.cancel();
    _onLikeAndUnLikePostSub.cancel();
  }

  @override
  PagingRepo get dataRepo => _repo;
}