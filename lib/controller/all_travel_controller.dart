import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:travelkuy_dashboard/model/travel_model.dart';

import '../widgets/loading.dart';

class AllTravelController extends GetxController {
  RxList<Travel> travels = RxList<Travel>([]);
  late Travel travel ;
  late TextEditingController from,to,price;
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  auth.User? user;
  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("Travel");
    travels.bindStream(getAllTravel());
    from = TextEditingController();
    to = TextEditingController();
    price = TextEditingController();
    super.onInit();
  }

  Stream<List<Travel>> getAllTravel() =>
      collectionReference.snapshots().map((query) => query.docs
          .map((item) => Travel.fromMap(item))
          .toList());
  Future<Travel> getTravelById(String id) async{
    var res = await collectionReference.doc(id).get();
    travel = Travel.fromMap(res);
    return travel;
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "This field can be empty";
    }
    return null;
  }

  void changeFrom(String id) async{
    Get.defaultDialog(
        title: 'تعديل',
        content:
        SingleChildScrollView(
          child: TextFormField(
            controller: from,
            decoration:const InputDecoration(
              icon:
              Icon(Icons.account_circle),
              // labelText: 'Username',
            ),
            validator: (value){
              return validate(value!);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showdilog();
              try{
                 await collectionReference.doc(id).update({"from":from.text});
                await getTravelById(id);
                update(['from']);
                from.clear();
                Get.back();
                Get.back();
                Get.snackbar('تعديل', 'تم التعديل',backgroundColor: Colors.greenAccent);
              }catch(e){
                Get.back();
                Get.back();
                Get.snackbar('تعديل', e.toString());
              }

            },
            child: const Text(
              "تعديل",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20),
            ),

          ),
    TextButton(
    onPressed: ()  {

    Get.back();
    from.clear();


    },
    child: const Text(
    "الغاء",
    style: TextStyle(
    color: Colors.black,
    fontSize: 20),
    )),
        ]
    );
    // var res = await collectionReference.doc(id).update(attribute);
  }
  void changeTo(String id) async{
    Get.defaultDialog(
        title: 'تعديل',
        content:
        SingleChildScrollView(
          child: TextFormField(
            controller: to,
            decoration:const InputDecoration(
              icon:
              Icon(Icons.account_circle),
              // labelText: 'Username',
            ),
            validator: (value){
              return validate(value!);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showdilog();
              try{
                await collectionReference.doc(id).update({"to":to.text});
                await getTravelById(id);
                update(['to']);
                to.clear();
                Get.back();
                Get.back();
                Get.snackbar('تعديل', 'تم التعديل',backgroundColor: Colors.greenAccent);
              }catch(e){
                Get.back();
                Get.back();
                Get.snackbar('تعديل', e.toString());
              }

            },
            child: const Text(
              "تعديل",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20),
            ),

          ),
          TextButton(
              onPressed: ()  {
                Get.back();
                from.clear();
              },
              child: const Text(
                "الغاء",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20),
              )),
        ]
    );
    // var res = await collectionReference.doc(id).update(attribute);
  }
  void changePrice(String id) async{
    Get.defaultDialog(
        title: 'تعديل',
        content:
        SingleChildScrollView(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: price,
            decoration:const InputDecoration(
              icon:
              Icon(Icons.account_circle),
              // labelText: 'Username',
            ),
            validator: (value){
              return validate(value!);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showdilog();
              try{
                await collectionReference.doc(id).update({"price":int.tryParse(price.text)});
                await getTravelById(id);
                update(['price']);
                price.clear();
                Get.back();
                Get.back();
                Get.snackbar('تعديل', 'تم التعديل',backgroundColor: Colors.greenAccent);
              }catch(e){
                Get.back();
                Get.back();
                Get.snackbar('تعديل', e.toString());
              }

            },
            child: const Text(
              "تعديل",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20),
            ),

          ),
          TextButton(
              onPressed: ()  {
                Get.back();
                from.clear();
              },
              child: const Text(
                "الغاء",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20),
              )),
        ]
    );
    // var res = await collectionReference.doc(id).update(attribute);
  }
}