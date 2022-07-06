import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socail/common/widgets/stateful/upload/manage_group/upload_group_state_ctrl.dart';
import 'package:socail/common/widgets/stateful/upload/manage_group/upload_group_value.dart';
import 'package:socail/common/widgets/stateful/upload/widgets/upload_item.dart';
import 'package:socail/modules/posts/models/picture.dart';
import 'package:socail/providers/api_provider.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'image_upload_item.dart';

class ImageUploadGroup extends StatefulWidget {
  final int maxImage;
  final List<ImageUploadItem> listImages;
  final String folder;
  final bool isFulGrid;
  final Function(UploadGroupValue) onValueChange;

  const ImageUploadGroup(
      {Key? key,
      this.maxImage = 5,
      required this.listImages,
      required this.onValueChange,
      this.folder = "post",
      this.isFulGrid = true})
      : super(key: key);

  @override
  State<ImageUploadGroup> createState() => _ImageUploadGroupState();
}

class _ImageUploadGroupState extends State<ImageUploadGroup> {
  final apiProvider = ApiProvider();
  final controller = UploadGroupStateController();
  List<ImageUploadItem> _listImageParam = <ImageUploadItem>[];
  int maxImageInRow = 3;
  int spacing = 8;
  int? _imgWidth;
  int? _imgHeight;
  double aspecRatio = 0.75;
  int get maxImage => widget.maxImage;
  int get realMaxImage => maxImage - _listImageParam.where((e) => e.asset==null).length;
  bool get isReady => _listImageParam.where((e) => e.id =="").isEmpty;
  // List<Asset> get _selectedAsset => _listImageParam.where((e) => e.asset != null)
  //     .map((e) => e.asset!).toList();
  List<XFile> get _selectedAsset => _listImageParam.where((e) => e.asset != null)
      .map((e) => e.asset!).toList();
  @override
  initState(){
    super.initState();
    _listImageParam = widget.listImages;
    controller.addListener(_didChangeValue);
  }
  @override
  dispose(){
    controller.removeListener(_didChangeValue);
    super.dispose();
  }
  void _didChangeValue(){
    widget.onValueChange(controller.value);
  }
  @override
  Widget build(BuildContext context) {
    final screeenWidth = MediaQuery.of(context).size.width;
    const magingHorizontal = 16;
    _imgWidth = ((screeenWidth-(magingHorizontal*2-(spacing*(maxImageInRow-1))))~/maxImageInRow).toInt();
    return buildGridView();
  }
  Widget buildGridView(){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: maxImageInRow,
          childAspectRatio: aspecRatio,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8
        ),
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.isFulGrid?maxImage:min(_listImageParam.length+1,maxImage),
        itemBuilder: (context, index){
          if(widget.isFulGrid){
            if(index>=_listImageParam.length){
              return buildItemImage(image:_listImageParam[index],index: index );
            }else{
              return buildItemImage(image: _listImageParam[index], index: index);
            }
          }else{
            if(index < _listImageParam.length){
              return buildItemImage(image: _listImageParam[index], index: index);
            }
            if(index == _listImageParam.length)return buildItemAddImage(index);
            return Container();
          }
        });

  }
  Widget buildItemImage({required ImageUploadItem image,required int index}){

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey,width: 1)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: UploadItem(
              controller: image.controller!,
              onDelete: ()=>removeImage(index),
              showDeleteButton: true,
              placeHolder: image.placeHolder,
            ),
          ),
        )
      ],
    );
  }
  void removeImage(index){
    final imgUplItem = _listImageParam[index];
    imgUplItem.cancelToken!.cancel;
    _listImageParam.removeAt(index);
    setState((){});
    controller.value = controller.value.withValue(_listImageParam);
  }
  void upLoadImage(ImageUploadItem item)async{
    try{
      FormData formData;
      // var originData = await item.asset!.getByteData();
      var originData = await item.asset!.readAsBytes();
      formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(originData.buffer.asInt8List(),
        filename: '${DateTime.now().microsecond}.jpg'),
        'folder': widget.folder
      });
      var result = await apiProvider.post('/upload',data: formData,onSendProgress: (int sent,int total){
        if(sent==total){
          item.controller!.progress=0.999;
        }else{
          item.controller!.progress = sent/total;
        }
      },
        cancelToken: item.cancelToken);
      print('ketqua: ${result}');
      item.id = result.data['data']['id'];
      item.picture = Picture.fromJson(result.data['data']['image']);
      item.controller!.progress = 1.0;
      controller.value = controller.value.withValue(_listImageParam);

    }catch(e){
      debugPrint('${e}');
      item.setError(e.toString());
      final idx = _listImageParam.indexOf(item);
      removeImage(idx);

    }
  }

  Widget buildItemAddImage(int index) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: ()async{
          await chooseAndUploadImage();
    },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 5.0,
            left: 5.0,
            child: Text('${index+1}'),
          ),
          const Positioned(
            top: 5.0,
            right: 5.0,
            child: Material(
              elevation: 3.0,
              shape: CircleBorder(),
              child: Icon(
                Icons.add_circle,
                size: 25,
              ),
            ),
          )
        ],

      ),
      ),
    );
  }
  Future<void> chooseAndUploadImage() async {
    // List<Asset> resultList = <Asset>[];
    List<XFile>? resultList = [];
    void _setImageFileListFromFile(XFile? value) {
      resultList = value == null ? null : <XFile>[value];
    }

    var localListImg = <ImageUploadItem>[];

    final currentStatus = await Permission.photos.status;

    if (currentStatus == PermissionStatus.denied ||
        currentStatus == PermissionStatus.restricted) {
      await Permission.photos.request();
    } else if (currentStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    final ImagePicker _picker = ImagePicker();

    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage();
      if(pickedFileList!.isNotEmpty){
        setState((){
          resultList = pickedFileList;

        });
        // resultList.addAll(pickedFileList);
      }

      // resultList = await MultiImagePicker.pickImages(
      //   maxImages: realMaxImage,
      //   enableCamera: true,
      //   selectedAssets: _selectedAsset,
      //   cupertinoOptions: const CupertinoOptions(
      //     takePhotoIcon: "chat",
      //     //backgroundColor: "#${Colors.black.value.toRadixString(16)}",
      //   ),
      //   materialOptions: const MaterialOptions(
      //     actionBarColor: "#abcdef",
      //     actionBarTitle: "Dofhunt",
      //     allViewTitle: "All Photos",
      //     useDetailsView: false,
      //     selectCircleStrokeColor: "#000000",
      //   ),
      // );

      if (resultList!.isEmpty) return;

      for (int i = 0; i < resultList!.length; i++) {
        var r = resultList![i];

        String? imageName = r.name;

        if (_listImageParam.isNotEmpty) {
          var foundIdx =
          (_listImageParam.indexWhere((x) => x.name == imageName));

          if (foundIdx != -1) {
            localListImg.add(_listImageParam[foundIdx]);
            continue;
          }
        }

        // var thumbData = await r.getThumbByteData(
        //     _imgWidth!.ceil() * 2, _imgHeight!.ceil() * 2,
        //     quality: 100);
        // var placeHolder = Image.memory(thumbData.buffer.asUint8List());
        var placeHolder = Image.network('https://phocode.com/wp-content/uploads/2020/10/placeholder-1-1.png');

        ImageUploadItem imageParam =
        ImageUploadItem(r, imageName!, placeHolder);
        localListImg.add(imageParam);

        upLoadImage(imageParam);
      }

      _listImageParam = [
        ..._listImageParam.where((e) => e.asset == null).toList(),
        ...localListImg
      ];
      // update controller value
      controller.value = controller.value.withValue(_listImageParam);
    } on Exception catch (e) {
      debugPrint('$e');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (resultList!.isNotEmpty) {
      setState(() {});

      final copyList = _listImageParam.toList();

      for (int i = 0; i < copyList.length; i++) {
        if (i >= _listImageParam.length) continue;
        if (_listImageParam[i].state == "init") upLoadImage(_listImageParam[i]);
      }
    }
  }
}
