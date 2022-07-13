import 'package:flutter/material.dart';
import 'package:socail/values/app_styles.dart';

import '../../../values/app_colors.dart';
import 'circle_avatar_border.dart';

class ItemRow extends StatelessWidget {
  final String? avatarUrl;
  final double sizeAvatar;
  final String? title;
  final String? subtitle;

  final Widget? avatarWidget;
  final Widget? bodyWidget;
  final Widget? rightWidget;

  final VoidCallback? onTap;

  const ItemRow({
    Key? key,
    this.avatarUrl,
    this.sizeAvatar = 36,
    this.title,
    this.subtitle,
    this.avatarWidget,
    this.bodyWidget,
    this.rightWidget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: GradientAppColor.bg_copy,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildAvatar(context),
                const SizedBox(width: 8),
                bodyWidget ?? buildBodyWidget(context),
              ],
            ),
          ),
          rightWidget ?? PopupMenuButton(
              itemBuilder: (context)=>[
                PopupMenuItem(
                  onTap: (){
                    // todo:
                  },
                  value: 2,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.save),
                        ),
                        Text('Save')
                      ],
                    )),
                PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.share),
                        ),
                        Text('Share Post')
                      ],
                    )),
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.edit),
                        ),
                        Text('Edit Post')
                      ],
                    )),
              ]),
        ],
      ),
    );
  }

  Widget buildBodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildTitle(context),
        buildSubTitle(context),
      ],
    );
  }

  Widget buildAvatar(BuildContext context) {
    Widget? built = avatarWidget;

    if (built == null && avatarUrl != null) {
      built = CircleAvatarBorder(avatarUrl: avatarUrl, size: sizeAvatar);
    }

    if (built != null && onTap != null) {
      built = GestureDetector(child: built, onTap: onTap);
    }

    return built ?? const SizedBox.shrink();
  }

  Widget buildTitle(BuildContext context) {
    Widget? built;

    if (title != null) {
      built = Text(
        title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.h2,
      );
    }

    if (built != null && onTap != null) {
      built = GestureDetector(child: built, onTap: onTap);
    }

    if (built != null) {
      built = Flexible(child: built);
    }

    return built ?? const SizedBox.shrink();
  }

  Widget buildSubTitle(BuildContext context) {
    if (subtitle == null) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        subtitle!,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.grey[600]),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
