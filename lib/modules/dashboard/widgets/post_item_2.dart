import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../posts/models/post.dart';
import '../../posts/widgets/grid_image.dart';

class PostItem2 extends StatefulWidget {
  final double? height;
  final Post? item;
  final String? description;

  const PostItem2({
    Key? key,
    this.height,
    required this.item,
    required this.description,
  }) : super(key: key);

  @override
  _PostItem2State createState() => _PostItem2State();
}

class _PostItem2State extends State<PostItem2> {
  late double? _height;
  late Post? _item;

  @override
  void initState() {
    _height = widget.height;
    _item = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF242A37),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(3, 6))
          ]),
      child: Column(
        children: [
          //infor Widget
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              widget.description ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          GridImage(
            photos: _item?.photos ?? [],
          )
        ],
      ),
    );
  }
}
