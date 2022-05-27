import 'package:cloud_firestore/cloud_firestore.dart';

class Travel {
  String? id;
  int? No;
  String? from;
  String? to;
  String? image;
  DateTime? time;
  int? count;
  int? price;

  Travel({
    this.id,
    required this.time,
    required this.No,
    required this.from,
    required this.to,
    required this.image,
    required this.count,
    required this.price,
  });

  Travel.fromMap(DocumentSnapshot data) {
    id = data.id;
    No = data["No"];
    from = data["from"];
    to = data["to"];
    image = data["image"];
    count = data["count"];
    time = data["time"].toDate();
    price = data["price"];
  }
}
