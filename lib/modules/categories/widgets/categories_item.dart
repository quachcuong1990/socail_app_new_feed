import 'package:flutter/material.dart';
import 'package:socail/modules/categories/models/categories.dart';

import '../../posts/models/post.dart';
import '../models/category.dart';

class CategoriesItem extends StatelessWidget {
  final Categories? categories;
  const CategoriesItem({Key? key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(categories!.description??''),
      ],
    );
  }
}

