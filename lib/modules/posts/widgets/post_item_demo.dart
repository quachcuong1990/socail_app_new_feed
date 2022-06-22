import 'package:flutter/material.dart';
import '../../../common/widgets/stateless/item_row.dart';
import '../models/post.dart';

class PostItemDemo extends StatelessWidget {
  final
  Post post;

  const PostItemDemo({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: const [
          ItemRow(),
        ],
      ),
    );
  }
}
