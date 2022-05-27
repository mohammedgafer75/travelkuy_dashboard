import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/res_model.dart';

class AllReservationController extends GetxController{
  RxList<Resrvation> reservaiton = RxList<Resrvation>([]);
  @override
  void onInit() {
    reservaiton.bindStream(getResrviation());
    super.onInit();
  }
  Stream<List<Resrvation>> getResrviation() =>
      FirebaseFirestore.instance.collection('Reservtions').
      snapshots().map((query) => query.docs
          .map((item) => Resrvation.fromMap(item))
          .toList());
}