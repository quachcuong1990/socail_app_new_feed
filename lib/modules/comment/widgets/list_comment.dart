import 'package:flutter/material.dart';
import 'package:socail/modules/comment/models/comment.dart';
import '../../../common/widgets/stateless/activity_indicator.dart';
import '../../../providers/bloc_provider.dart';
import '../blocs/comments_bloc.dart';
import 'comment_item_bubble.dart';

class ListComment extends StatefulWidget {
  const ListComment({Key? key}) : super(key: key);

  @override
  _ListCommentState createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  CommentBloc? get commentBloc => BlocProvider.of<CommentBloc>(context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Comment>?>(
      stream: commentBloc!.listCmtStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: ActivityIndicator(),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 12),
              child: const Center(
                child: Text('No comment'),
              ),
            );
          }

          return ListView.builder(
            // controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final comment = snapshot.data![index];

              return Container(
                key: ValueKey(comment.id),
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: CommentItemBubble(
                        cmt: comment,
                        onReact: (type, isUnReact) {
                          if(!isUnReact){
                            commentBloc!.react(comment.id!, type);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: snapshot.data?.length ?? 0,
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        return const ActivityIndicator();
      },
    );
  }
}
