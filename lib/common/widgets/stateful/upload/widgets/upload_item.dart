import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../manage_one_item/upload_ctrl.dart';
class UploadItem extends StatefulWidget {
  final UploadController controller;
  final Widget? placeHolder;
  final VoidCallback onDelete;
  final bool showDeleteButton;
  const UploadItem({Key? key,
  required this.controller,
  this.placeHolder,
  required this.onDelete,
  this.showDeleteButton = true}) : super(key: key);

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {

  @override
  initState(){
    super.initState();
    widget.controller.addListener(_didChangeUploadValue);
  }
  @override
  void didUpdateWidget(UploadItem oldWidget){
    super.didUpdateWidget(oldWidget);
    if(widget.controller!=oldWidget.controller){
      oldWidget.controller.removeListener(_didChangeUploadValue);
      widget.controller.addListener(_didChangeUploadValue);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeUploadValue);
    super.dispose();
  }
  void _didChangeUploadValue(){
    setState((){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.controller.uri!=null?
            CachedNetworkImage(
                imageUrl: widget.controller.uri!,
            fit: BoxFit.cover,
            placeholder: (_,__)=> widget.controller.uri!=null
              ? Image.file(
              widget.controller.oriFile!,
              fit: BoxFit.cover,
            )
              :widget.placeHolder ?? Container(
              color: const Color(0xff4A4A4A),
            ),
              errorWidget: (context,url,error) =>
              Container(
                child: const Icon(Icons.error),
              ),
            )
            :widget.controller.oriFile!=null?
            Image.file(widget.controller.oriFile!,
            fit: BoxFit.cover,)
            :widget.placeHolder??
    Container(
      color: const Color(0xff4A4A4A),
    ),
        (widget.controller.uri!=null || widget.controller.uri !='') &&
            (widget.controller.progress == 1.0 || widget.controller.progress ==null)
        ?Container()
            :Container(
          color: const Color.fromRGBO(0, 0, 0, 0.5),
        ),
        if(showCircular())
          Center(
            child: Theme(
              data: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Theme.of(context).canvasColor)
              ),
              child: CircularProgressIndicator(
                value: widget.controller.progress,
              ),
            ),
          ),
        if(widget.showDeleteButton)
          Positioned(
            top: -8,
            right: -5,
            child: ButtonTheme(
              minWidth: 20,
              child: FlatButton(
                padding: const EdgeInsets.all(0),
                onPressed: widget.onDelete,
                color: Colors.white,
                shape: const CircleBorder(
                    side: BorderSide(color: Colors.transparent)),
                child: Icon(
                  Icons.close,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).accentColor,
                  size: 16,
                ),
              ),
            ),
          )
      ],
    );
  }
  bool showCircular(){
    return widget.controller.progress!=null && widget.controller.progress !=1.0;
  }
}
