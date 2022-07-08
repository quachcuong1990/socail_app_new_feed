import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socail/common/widgets/stateless/circle_avatar_border.dart';
import 'package:socail/modules/categories/blocs/list_categories_rxdart_bloc.dart';
import 'package:socail/modules/categories/models/categories.dart';
import 'package:socail/modules/categories/models/duongdan.dart';
import 'package:socail/modules/posts/widgets/post_item.dart';
import 'package:socail/values/app_colors.dart';
import '../../../blocs/app_state_bloc.dart';
import '../../../providers/bloc_provider.dart';
import '../../../route/route_name.dart';
import '../../../values/app_styles.dart';
import '../../categories/models/category.dart';
import '../../categories/widgets/categories_item.dart';
import '../../posts/blocs/list_posts_rxdart_bloc.dart';
import '../../posts/models/post.dart';
import '../widgets/post_item_2.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // ListCategoriesRxDartBloc? get blocCategories => BlocProvider.of<ListCategoriesRxDartBloc>(context);
  final _blocCategories = ListCategoriesRxDartBloc();
  ListPostsRxDartBloc? get bloca => BlocProvider.of<ListPostsRxDartBloc>(context);

  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState(){
    super.initState();
    _blocCategories.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    var photoUrl = user?.photoURL;
    print('photo url =====${photoUrl}');
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
            margin: const EdgeInsets.only(left: 14.0, top: 48.0, right: 17.0),
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.greyColor1,
                        hintText: 'Search here',
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.white,
                        contentPadding: const EdgeInsets.only(bottom: 36 / 2),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: BorderSide.none)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      appStateBloc!.changeAppState(AppState.unAuthorized);
                    },
                    child:  CircleAvatarBorder(
                      avatarUrl:photoUrl,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 14.0, top: 18.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Discovery',
                style: AppStyles.h4,
              )),
          Container(
            height: 200,
            child: Flexible(
              child: StreamBuilder<List<Categories>?>(
                stream: _blocCategories!.categoriesStream,
                  builder: (context,snapshot){
                  if(snapshot.hasData){
                    final categories = snapshot.data;
                    print('categories : ${categories}');
                    return ListView.builder(
                      shrinkWrap: true,
                        itemBuilder: (_,int index){
                          final item = categories![index];
                          print('object==${item}');
                          return   CategoriesItem(categories: item,);
                        },
                      itemCount: categories!.length,
                        );
                  }
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                  }),
            ),
          ),
          const SizedBox(
            height: 19,
          ),

          Expanded(
            child: Flexible(
              child: StreamBuilder<List<Post>?>(
                  stream: bloca!.postsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final posts = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
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
          ),
        ],
      ),
    );
  }
}
