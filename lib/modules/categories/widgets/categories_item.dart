import 'package:flutter/material.dart';
import 'package:socail/modules/categories/models/categories.dart';
import 'package:socail/modules/posts/models/picture.dart';


class CategoriesItem extends StatelessWidget {
  final List<Picture>? picture;
  const CategoriesItem({Key? key, required this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('image=====${picture![0].url}');
    return Container(
    );
  }
}

