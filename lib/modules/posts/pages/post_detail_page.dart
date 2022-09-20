import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/mixin/dialog_err_mixin.dart';
import '../../../common/widgets/stateless/item_row.dart';
import '../../../providers/bloc_provider.dart';
import '../../comment/blocs/comments_bloc.dart';
import '../../comment/widgets/list_comment.dart';
import '../../profile/pages/profile_page.dart';
import '../blocs/post_detail_bloc.dart';
import '../models/post.dart';
import '../widgets/action_post.dart';
import '../widgets/grid_image.dart';


class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> with DialogErrorMixin {
  Post get post => widget.post;

  PostDetailBloc? get bloc => BlocProvider.of<PostDetailBloc>(context);

  CommentBloc? get cmtBloc => BlocProvider.of<CommentBloc>(context);

  late final TextEditingController txtCtrl;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    bloc!.getPost();

    cmtBloc!.getComments();

    txtCtrl = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    txtCtrl.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Post>(
          stream: bloc!.postsStream,
          initialData: widget.post,
          builder: (context, snapshot) {
            final post = snapshot.data;
            return Stack(
              children: [
                CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        title: const Text('Post Detail Page'),
                        snap: true,
                        floating: true,
                        elevation: 1,
                        forceElevated: true,
                        actions: [
                          IconButton(
                              onPressed: _writeCmt, icon: const Icon(Icons.add))
                        ],
                      ),
                      CupertinoSliverRefreshControl(
                        onRefresh: bloc!.getPost,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                              child: ItemRow(
                                avatarUrl: post!.urlUserAvatar,
                                title: post.displayName,
                                subtitle: 'Time created',
                                onTap: () =>
                                    navigateToProfilePage(context, post.user),
                                rightWidget: IconButton(
                                  onPressed: deletePost,
                                  icon: const Icon(Icons.more_horiz),
                                ),
                              ),
                            ),
                            if (post.photos != null)
                              GridImage(photos: post.photos!, padding: 0),
                            ActionPost(post: post),
                            const Divider(thickness: 1),
                            const ListComment(),
                          ],
                        ),
                      ),
                    ]),
              ],
            );
          }),
    );
  }

  Future<void> _writeCmt() async {
    try {
      return cmtBloc!.writeCmt('I love this picture ^^');
    } catch (e) {
      showErrorMessage('Write comment error');
    }
  }

  Future<void> deletePost() async {
    try {
      return bloc!.deletePost().then((value) {
        Navigator.pop(context);
      });
    } catch (e) {}
  }
}
