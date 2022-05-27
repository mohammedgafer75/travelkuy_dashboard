import 'package:cloud_firestore/cloud_firestore.dart';

class Resrvation {
  String? id;
  String? travelId;
  String? userId;
  String? name;
  String? from;
  String? to;
  DateTime? time;
  int? passNumber;
  int? number;
  int? price;

  Resrvation({
    this.id,
    required this.time,
    required this.travelId,
    required this.name,
    required this.from,
    required this.to,
    required this.passNumber,
    required this.price,
    required this.number,

  });

  Resrvation.fromMap(DocumentSnapshot data) {
    id = data.id;
    travelId = data["travelId"];
    name = data["name"];
    from = data["from"];
    to = data["to"];
    passNumber = data["passNumber"];
    price = data["price"];
    number = data["number"];
    time = data["time"].toDate();

  }
}
