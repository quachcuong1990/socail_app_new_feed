import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../blocs/app_state_bloc.dart';
import '../../../common/widgets/stateless/activity_indicator.dart';
import '../../../providers/bloc_provider.dart';
import '../../../route/route_name.dart';
import '../blocs/list_posts_rxdart_bloc.dart';
import '../models/post.dart';
import '../widgets/post_item_remake.dart';

class ListPostsPage extends StatefulWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  _ListPostsPageState createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  final _postsBloc = ListPostsRxDartBloc();
  late final ScrollController _scrollCtrl;
  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);


  @override
  void initState() {
    super.initState();
    // _postsBloc.add('getPosts');
    _postsBloc.getPosts();
    _scrollCtrl = ScrollController();
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
                    appStateBloc!.changeAppState(AppState.unAuthorized);

                    // Navigator.pushNamed(context, '/day09');
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
}
