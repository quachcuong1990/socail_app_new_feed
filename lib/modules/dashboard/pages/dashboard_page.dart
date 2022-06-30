import 'package:flutter/material.dart';
import 'package:socail/modules/posts/widgets/post_item.dart';
import 'package:socail/values/app_colors.dart';

import '../../../blocs/app_state_bloc.dart';
import '../../../providers/bloc_provider.dart';
import '../../../route/route_name.dart';
import '../../posts/blocs/list_posts_rxdart_bloc.dart';
import '../../posts/models/post.dart';
import '../widgets/post_item_2.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ListPostsRxDartBloc? get bloc =>
      BlocProvider.of<ListPostsRxDartBloc>(context);
  AppStateBloc? get appStateBloc =>
      BlocProvider.of<AppStateBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GradientAppColor.bg_copy,
      // appBar: AppBar(
      //   backgroundColor: GradientAppColor.bg_copy,
      //   title: const Text('List posts page'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       onPressed: () {
      //         appStateBloc!.changeAppState(AppState.unAuthorized);
      //       },
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, RouteName.createPostPage);
        },
      ),
      body: Column(
        children: [
           Container(
             margin: const EdgeInsets.only(left: 14.0,top: 48.0),
             height: 36,
             child: TextField(
               style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.greyColor1,
                hintText: 'Search here',
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide.none
                )
              ),
          ),
           ),
          Flexible(
            child: StreamBuilder<List<Post>?>(
                stream: bloc!.postsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final posts = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (_, int index) {
                        final item = posts![index];
                        return PostItem(
                          // height: 200,
                          post: item,
                        );
                      },
                      itemCount: posts?.length ?? 0,
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
