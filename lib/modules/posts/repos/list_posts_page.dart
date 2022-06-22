import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/widgets/post_item_2.dart';
import '../../tags/pages/tag_search_delegate.dart';
import '../blocs/list_posts_bloc.dart';


class ListPostsPage extends StatefulWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  _ListPostsPageState createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  final _postsBloc = ListPostsBloc();

  @override
  void initState() {
    super.initState();
    _postsBloc.add('getPosts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List posts page'),
        actions: [
          TagSearchDelegate.buildIconButton(_postsBloc),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: _buildLogo(),
        onPressed: () {},
      ),
      body: BlocBuilder<ListPostsBloc, ListPostsState>(
        bloc: _postsBloc,
        builder: (context, state) {
          final posts = state.posts;
          if (posts != null) {
            return ListView.builder(
              itemBuilder: (_, int index) {
                final item = posts[index];
                return PostItem2(
                  height: 200,
                  // url: item.images?.first.url ?? '',
                  description: item.description!, item: item,
                );
              },
              itemCount: posts.length,
            );
          }

          final error = state.error;
          if (error != null) {
            return Center(
              child: Text(error.toString()),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    // print('_buildLogo ------- build');
    return SizedBox(
      width: 64,
      height: 64,
      child: Image.asset('assets/images/flutter_logo.png'),
    );
  }
}
