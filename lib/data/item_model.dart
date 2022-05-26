import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import '../constants/data_keys.dart';

class ItemModel{
  // startData
  // startTime
  late String itemKey;
  late String userKey;
  late List<String> imageDownloadurls;
  late String title;
  late String category;
  late String requiredLevel;
  late bool requiredLevelSet;
  late String detail;
  late String address;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  late String appointmentTime;
  DocumentReference? reference;

  ItemModel({
    required this.itemKey,
    required this.userKey,
    required this.imageDownloadurls,
    required this.title,
    required this.category,
    required this.requiredLevel,
    required this.requiredLevelSet,
    required this.detail,
    required this.address,
    required this.geoFirePoint,
    required this.createdDate,
    required this.appointmentTime,
    this.reference,});

  ItemModel.fromJson(Map<String, dynamic> json, this.itemKey, this.reference) {
    itemKey = json['itemKey']??"";
    userKey = json['userKey']??"";
    imageDownloadurls = json['imageDownloadurls'] != null ? json['imageDownloadurls'].cast<String>() : [];
    title = json['title']??"";
    category = json['category']??"none";
    requiredLevel = json['requiredLevel']??"";
    requiredLevelSet = json['requiredLevelSet']??false;
    detail = json['detail']??"";
    address = json['address']??"";
    geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude, (json['geoFirePoint']['geopoint']).longitude);
    createdDate = json['createdDate']== null ? DateTime.now().toUtc(): (json['createdDate'] as Timestamp).toDate();
    reference = json['reference'];
    appointmentTime = json['appointmentTime'];
  }

  ItemModel.fromQuerySnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);
  ItemModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userKey'] = userKey;
    map['itemKey'] = itemKey;
    map['imageDownloadurls'] = imageDownloadurls;
    map['title'] = title;
    map['category'] = category;
    map['requiredLevel'] = requiredLevel;
    map['requiredLevelSet'] = requiredLevelSet;
    map['detail'] = detail;
    map['address'] = address;
    map['geoFirePoint'] = geoFirePoint.data;
    map['createdDate'] = createdDate;
    map['appointmentTime'] = appointmentTime;
    return map;
  }
  ItemModel.fromAlgoliaObject(Map<String, dynamic> json, this.itemKey) {
    userKey = json[DOC_USERKEY] ?? "";
    imageDownloadurls = json[DOC_IMAGEDOWNLOADURLS] != null
        ? json[DOC_IMAGEDOWNLOADURLS].cast<String>()
        : [];
    title = json[DOC_TITLE] ?? "";
    category = json[DOC_CATEGORY] ?? "none";
    requiredLevel = json[DOC_PRICE] ?? "";
    requiredLevelSet = json[DOC_NEGOTIABLE] ?? false;
    detail = json[DOC_DETAIL] ?? "";
    address = json[DOC_ADDRESS] ?? "";
    geoFirePoint = GeoFirePoint(0, 0);
    createdDate = DateTime.now().toUtc();
    appointmentTime = json[DOC_APPOINTMENTTIME]??"";
  }

  static String generateItemKey(String uid){
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    return '${uid}_${timeInMilli}';
  }
}


