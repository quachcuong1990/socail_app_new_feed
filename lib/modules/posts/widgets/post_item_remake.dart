import 'package:flutter/material.dart';

import '../../../common/widgets/stateless/item_row.dart';
import '../../../route/route_name.dart';
import '../../profile/pages/profile_page.dart';
import '../models/post.dart';
import 'action_post.dart';
import 'grid_image.dart';


class PostItemRemake extends StatefulWidget {
  final Post post;

  const PostItemRemake({Key? key, required this.post}) : super(key: key);

  @override
  State<PostItemRemake> createState() => _PostItemRemakeState();
}

class _PostItemRemakeState extends State<PostItemRemake> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () => _navigateToPostDetailPage(context),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: ItemRow(
                    avatarUrl: widget.post.urlUserAvatar,
                    title: widget.post.displayName,
                    subtitle: 'Time created',
                    onTap: () =>
                        navigateToProfilePage(context, widget.post.user),
                  ),
                ),
                GridImage(photos: widget.post.photos!),
                ActionPost(post: widget.post),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPostDetailPage(BuildContext context) {
    Navigator.pushNamed(context, RouteName.postDetailPage,
        arguments: widget.post);
  }
}
