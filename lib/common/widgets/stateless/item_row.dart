import 'package:flutter/material.dart';

import 'circle_avatar_border.dart';

class ItemRow extends StatelessWidget {
  final String? avatarUrl;
  final double? sizeAvatar;
  final String? title;
  final String? subtitle;

  final Widget? avatarWidget;
  final Widget? bodyWidget;
  final Widget? rightWidget;

  const ItemRow({
    Key? key,
    this.avatarUrl,
    this.sizeAvatar,
    this.title,
    this.subtitle,
    this.avatarWidget,
    this.bodyWidget,
    this.rightWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              avatarWidget ?? CircleAvatarBorder(
                avatarUrl: avatarUrl,
                size: sizeAvatar!,
              ),
              const SizedBox(width: 8),
              bodyWidget ?? buildBodyWidget(context),
            ],
          ),
        ),
        rightWidget ?? const SizedBox(),
      ],
    );
  }

  Widget buildBodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitle(context),
        buildSubTitle(context),
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    if (title == null) {
      return const SizedBox();
    }

    return Flexible(
      child: Text(
        title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).primaryTextTheme.bodyText1,
      ),
    );
  }

  Widget buildSubTitle(BuildContext context) {
    if(subtitle == null){
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        subtitle!,
        style: Theme.of(context).textTheme.bodyText1,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
