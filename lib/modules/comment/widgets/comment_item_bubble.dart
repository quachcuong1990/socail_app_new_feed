import 'package:flutter/material.dart';
import 'package:socail/modules/comment/models/comment.dart';

import '../../../common/widgets/stateful/react_button/reactive_button.dart';
import '../../../common/widgets/stateful/react_button/reactive_icon_definition.dart';
import '../../../common/widgets/stateless/item_row.dart';
import '../../../utils/uidata.dart';


class CommentItemBubble extends StatefulWidget {
  final Comment cmt;
  final Function(int, bool) onReact;

  const CommentItemBubble({
    Key? key,
    required this.cmt,
    required this.onReact,
  }) : super(key: key);

  @override
  State<CommentItemBubble> createState() => _CommentItemBubbleState();
}

class _CommentItemBubbleState extends State<CommentItemBubble> {
  late final Comment cmt;
  int? yourReact = 0;

  @override
  void initState() {
    super.initState();

    cmt = widget.cmt;
    yourReact = cmt.metaData?.yourReact ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: ItemRow(
            avatarUrl: cmt.urlUserAvatar,
            title: cmt.displayName,
            subtitle: cmt.content!,
            sizeAvatar: 32,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Text('Time created',style: Theme.of(context).textTheme.bodyText2,),
              const SizedBox(width: 12,),
              buildReactButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildReactButton(BuildContext context) {
    late final Text textWidget;
    switch (yourReact) {
      case 1:
        textWidget = Text(
          'Like',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
        );
        break;
      case 2:
        textWidget = Text(
          'Haha',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
        );
        break;
      case 3:
        textWidget = Text(
          'Heart',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
        );
        break;
      case 4:
        textWidget = Text(
          'Sad',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
        );
        break;
      case 5:
        textWidget = Text(
          'Wow',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
        );
        break;
      case 6:
        textWidget = Text(
          'Angry',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
        );
        break;
      default:
        textWidget = Text(
          'Like',
          style: Theme.of(context).textTheme.bodyText2,
        );
    }
    return ReactiveButton(
      icons: <ReactiveIconDefinition>[
        ReactiveIconDefinition(
          assetIcon: UIData.likeGif,
          code: '1',
        ),
        ReactiveIconDefinition(
          assetIcon: UIData.hahaGif,
          code: '2',
        ),
        ReactiveIconDefinition(
          assetIcon: UIData.loveGif,
          code: '3',
        ),
        ReactiveIconDefinition(
          assetIcon: UIData.sadGif,
          code: '4',
        ),
        ReactiveIconDefinition(
          assetIcon: UIData.wowGif,
          code: '5',
        ),
        ReactiveIconDefinition(
          assetIcon: UIData.angryGif,
          code: '6',
        ),
      ], //_flags,
      onTap: () {
        widget.cmt.metaData?.yourReact == null ||
                widget.cmt.metaData!.yourReact == 0
            ? widget.onReact.call(1, false)
            : widget.onReact.call(0, true);
      },
      onSelected: (ReactiveIconDefinition? value) {
        // print('tap ${int.parse(value!.code)}');
        yourReact = int.parse(value!.code);
        setState(() {

        });
        // widget.onReact.call(int.parse(value.code), false);
      },
      iconWidth: 35.0,
      iconGrowRatio: 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.transparent),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.blueGrey,
            blurRadius: 1.3,
          ),
        ],
      ),
      containerPadding: 4,
      iconPadding: 5,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: textWidget,
      ),
    );
  }
}
