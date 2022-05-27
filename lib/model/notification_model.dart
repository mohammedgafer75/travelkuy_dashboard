import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String? travelId;
  int? No;
  DateTime? time;

  NotificationModel({
    this.id,
    required this.time,
    required this.No,
    required this.travelId,
  });

  NotificationModel.fromMap(DocumentSnapshot data) {
    id = data.id;
    No = data["No"];
    travelId = data["travelId"];
    time = data["time"].toDate();
  }
}
