import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/mixin/scroll_page_mixin.dart';
import '../../../common/widgets/stateless/activity_indicator.dart';
import '../../../route/route_name.dart';
import '../blocs/list_posts_rxdart_bloc.dart';
import '../models/post.dart';
import '../widgets/post_item_remake.dart';

class ListPostsPagingRepo extends StatefulWidget {
  const ListPostsPagingRepo({Key? key}) : super(key: key);

  @override
  _ListPostsPagingRepoState createState() => _ListPostsPagingRepoState();
}

class _ListPostsPagingRepoState extends State<ListPostsPagingRepo> with ScrollPageMixin{
  final _postsBloc = ListPostsRxDartBloc();
  late final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _postsBloc.getPosts();
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, RouteName.createPostPage),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollCtrl,
        slivers: <Widget>[
          SliverAppBar(
            title: const Text('Post'),
            snap: true,
            floating: true,
            elevation: 1,
            forceElevated: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/day09');
                  },
                  icon: const Icon(Icons.ac_unit))
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _postsBloc.getPosts,
          ),
          StreamBuilder<List<Post>?>(
              stream: _postsBloc.postsStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SliverFillRemaining(
                    child: ActivityIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const SliverFillRemaining(
                      child: Center(
                        child: Text('Something went wrong'),
                      ));
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final post = snapshot.data![index];
                      return PostItemRemake(post: post);
                    },
                    childCount: snapshot.data?.length ?? 0,
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  void loadMoreData() => _postsBloc.getPosts();

  @override
  ScrollController get scrollController => _scrollCtrl;
}
