import 'package:flutter/material.dart';
import 'package:socail/modules/categories/models/categories.dart';

import '../../posts/models/post.dart';

class CategoriesItem extends StatelessWidget {
  final Categories? categories;
  const CategoriesItem({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(categories!.description??''),
    );
  }
}

