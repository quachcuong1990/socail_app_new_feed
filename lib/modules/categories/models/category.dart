// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    required this.code,
    required this.data,
  });

  int code;
  List<Datum> data;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.description,
    this.photos,
    this.isCategory,
  });

  String? id;
  String? title;
  Description? description;
  List<Photo>? photos;
  bool? isCategory;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: descriptionValues.map[json["description"]],
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    isCategory: json["is_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": descriptionValues.reverse![description],
    "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
    "is_category": isCategory,
  };
}

enum Description { CC_NH_PH_BIN_NHT, CC_NH_MI_NHT, CC_NH_MI_V_ANG_C_QUAN_TM, CC_NH_P_NHT_C_BU_CHN, EMPTY }

final descriptionValues = EnumValues({
  "Các ảnh mới nhất": Description.CC_NH_MI_NHT,
  "Các ảnh mới và đang được quan tâm": Description.CC_NH_MI_V_ANG_C_QUAN_TM,
  "Các ảnh phổ biến nhất": Description.CC_NH_PH_BIN_NHT,
  "Các ảnh đẹp nhất được bầu chọn": Description.CC_NH_P_NHT_C_BU_CHN,
  "": Description.EMPTY
});

class Photo {
  Photo({
    this.id,
    this.title,
    this.description,
    this.image,
    this.exif,
    this.tags,
    this.commentCounts,
    this.likeCounts,
    this.viewCounts,
    this.collectionCounts,
    this.pulseScore,
    this.pulseType,
    this.isPrivate,
    this.isSensitive,
    this.storageLength,
    this.user,
    this.liked,
  });

  String? id;
  String? title;
  String? description;
  Image? image;
  dynamic? exif;
  dynamic? tags;
  int? commentCounts;
  int? likeCounts;
  int? viewCounts;
  int? collectionCounts;
  int? pulseScore;
  PulseType? pulseType;
  bool? isPrivate;
  bool? isSensitive;
  int? storageLength;
  dynamic? user;
  bool? liked;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: Image.fromJson(json["image"]),
    exif: json["exif"],
    tags: json["tags"],
    commentCounts: json["comment_counts"],
    likeCounts: json["like_counts"],
    viewCounts: json["view_counts"],
    collectionCounts: json["collection_counts"],
    pulseScore: json["pulse_score"],
    pulseType: pulseTypeValues.map[json["pulse_type"]],
    isPrivate: json["is_private"],
    isSensitive: json["is_sensitive"],
    storageLength: json["storage_length"],
    user: json["user"],
    liked: json["liked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image?.toJson(),
    "exif": exif,
    "tags": tags,
    "comment_counts": commentCounts,
    "like_counts": likeCounts,
    "view_counts": viewCounts,
    "collection_counts": collectionCounts,
    "pulse_score": pulseScore,
    "pulse_type": pulseTypeValues.reverse![pulseType],
    "is_private": isPrivate,
    "is_sensitive": isSensitive,
    "storage_length": storageLength,
    "user": user,
    "liked": liked,
  };
}

class Image {
  Image({
    this.url,
    this.orgWidth,
    this.orgHeight,
    this.orgUrl,
    this.cloudName,
    this.dominantColor,
    this.fileSize,
  });

  String? url;
  int? orgWidth;
  int? orgHeight;
  String? orgUrl;
  CloudName? cloudName;
  String? dominantColor;
  int? fileSize;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"],
    orgWidth: json["org_width"],
    orgHeight: json["org_height"],
    orgUrl: json["org_url"],
    cloudName: cloudNameValues.map[json["cloud_name"]],
    dominantColor: json["dominant_color"],
    fileSize: json["file_size"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "org_width": orgWidth,
    "org_height": orgHeight,
    "org_url": orgUrl,
    "cloud_name": cloudNameValues.reverse![cloudName],
    "dominant_color": dominantColor,
    "file_size": fileSize,
  };
}

enum CloudName { S3 }

final cloudNameValues = EnumValues({
  "s3": CloudName.S3
});

enum PulseType { POPULAR, FRESH, UP_COMING, EDITOR_CHOICE }

final pulseTypeValues = EnumValues({
  "editor_choice": PulseType.EDITOR_CHOICE,
  "fresh": PulseType.FRESH,
  "popular": PulseType.POPULAR,
  "up_coming": PulseType.UP_COMING,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
