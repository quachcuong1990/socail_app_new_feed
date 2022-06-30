import 'package:flutter/material.dart';
import 'package:socail/modules/posts/models/post.dart';
import 'package:socail/modules/posts/widgets/grid_image.dart';
import 'package:socail/values/app_colors.dart';
import 'package:socail/values/app_styles.dart';

import '../../../common/widgets/stateless/item_row.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({Key? key,required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = post.created_at;
    time = time?.substring(11,16);
    return Container(
      padding:const EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: GestureDetector(
        onTap: (){},
        child: Card(
          color: GradientAppColor.bg_copy,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12,12,12,8),
                  child: ItemRow(
                    avatarUrl: post.urlUserAvatar,
                    title: post.displayName ,
                    subtitle: time,
                  ),

                ),
                const SizedBox(height: 18.0,),
                Container(
                  alignment: Alignment.topLeft,
                    child: Text(post.description??'',style: AppStyles.h3.copyWith(color: Colors.white),)),
                const SizedBox(height: 13.0,),
                GridImage(photos:post.photos?? [],)
              ],
            ),
          ),

        ),
      ),
    );
  }
}
