import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelkuy_dashboard/widgets/loading.dart';
import 'dart:io';
import '../widgets/snackbar.dart';
import 'package:path/path.dart';

class AddTravelController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController from, to, count, price, no;
  DateTime time = DateTime.now();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;
  auth.User? user;

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    super.onInit();

    from = TextEditingController();
    to = TextEditingController();
    count = TextEditingController();
    price = TextEditingController();
    no = TextEditingController();

    collectionReference = firebaseFirestore.collection("Travel");
    // realestates.bindStream(getAllRealEstate());
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "الرجاء ادخال جميع البيانات";
    }
    if (value.isNum) {
      return "  الرجاء عدم ادخال ارقام ";
    }
    return null;
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "الرجاء ادخال جميع البيانات";
    }
    if (!value.isNum) {
      return "  الرجاء ادخال ارقام فقط ";
    }
     if (int.tryParse(value)!.isEven) {
      return "الرجاء ادخال ارقام موجبة";
    }
    return null;
  }

  void clear() {
    from.clear();
    to.clear();
    count.clear();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  void imageSelect() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      image = selectedImage;
      ch = 1;
      update(['image']);
    }
  }

  late String image_url;
  int ch = 0;
  Future uploadImageToFirebase() async {
    String fileName = basename(image!.path);

    var _imageFile = File(image!.path);

    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('mybus/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    await taskSnapshot.ref.getDownloadURL().then((value) {
      image_url = value;
    });
  }

  void addTravel() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      showdilog();
      await uploadImageToFirebase();
      if (image_url.isNotEmpty) {
        var re = <String, dynamic>{
          "No": int.tryParse(no.text),
          "from": from.text,
          "to": to.text,
          "count": int.tryParse(count.text),
          "time": time,
          "price": int.tryParse(price.text),
          "image": image_url
        };
        collectionReference.doc().set(re).whenComplete(() {
          Get.back();
          showbar(
              "Travel Added", "Travel Added", "تم اضافة الرحلة بي نجاح", true);
          clear();
        }).catchError((error) {
          Get.back();
          showbar("Error", "Error", error.toString(), false);
        });
      } else {
        showbar("Error", "Error", 'الرجاء اختيار صورة', false);
      }
    }
  }

  void getDatetime(BuildContext context) {
    BottomPicker.dateTime(
      title: "اختيار زمن الرحلة",
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
      onSubmit: (date) {
        time = date;
        update(['time']);
      },
      onClose: () {
        print("Picker closed");
      },
      buttonText: 'Confirm',
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: Colors.pink,
      minDateTime: DateTime.now(),
    ).show(context);
  }
}
