import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {
  String? id;
  String? uid;
  String? name;
  String? email;
  String? description;

  Complaint({
    this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.description,
  });

  Complaint.fromMap(DocumentSnapshot data) {
    id = data.id;
    uid = data["uid"];
    name = data["name"];
    email = data["email"];
    description = data["description"];
  }
}
