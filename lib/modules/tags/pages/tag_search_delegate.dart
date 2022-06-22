import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../posts/blocs/list_posts_bloc.dart';

class TagSearchDelegate extends SearchDelegate {
  final ListPostsBloc bloc;

  TagSearchDelegate(this.bloc);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.add(query);

    return BlocBuilder<ListPostsBloc, ListPostsState>(
      bloc: bloc,
      builder: (context, state) => ListView.builder(
        itemBuilder: (context, i) => ListTile(
          title: Text(state.tagList![i]),
        ),
        itemCount: state.tagList?.length ?? 0,
      ),
    );
  }

  static Widget buildIconButton(ListPostsBloc bloc) => Builder(
        builder: (context) => IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: TagSearchDelegate(bloc),
            );
          },
          icon: const Icon(Icons.search),
        ),
      );
}
