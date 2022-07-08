import 'package:flutter/material.dart';

class TopRowHome extends StatelessWidget {
  final Widget? search;
  final Widget? avatarProfile;
  final VoidCallback? onTap;

  TopRowHome({Key? key,this.search,this.avatarProfile,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

      ],
    );
  }
}
