import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelkuy_dashboard/model/complaints_model.dart';
import 'package:travelkuy_dashboard/model/notification_model.dart';
import 'package:travelkuy_dashboard/screens/home_screen.dart';
import 'package:travelkuy_dashboard/screens/login_page.dart';
import 'package:travelkuy_dashboard/widgets/custom_textfield.dart';
import 'package:travelkuy_dashboard/widgets/loading.dart';
import 'package:travelkuy_dashboard/widgets/snackbar.dart';

import '../model/user_model.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  RxList<Users> users = RxList<Users>([]);
  RxList<NotificationModel> not = RxList<NotificationModel>([]);
  RxList<Complaint> complaints = RxList<Complaint>([]);
  late CollectionReference collectionReference;
  late CollectionReference collectionReference2;
  late CollectionReference collectionReference3;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController email,
      name,
      password,
      Rpassword,
      repassword,
      number,
      No;

  bool ob = false;
  bool obscureTextLogin = true;
  bool obscureTextSignup = true;
  bool obscureTextSignupConfirm = true;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Widget route;
  @override
  void onReady() {
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    collectionReference = firebaseFirestore.collection("users");
    collectionReference2 = firebaseFirestore.collection("complaints");
    collectionReference3 = firebaseFirestore.collection("notification");
    email = TextEditingController();
    password = TextEditingController();
    Rpassword = TextEditingController();
    repassword = TextEditingController();
    number = TextEditingController();
    name = TextEditingController();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    users.bindStream(getAllUser());
    not.bindStream(getAllNotification());
    complaints.bindStream(getAllComplaint());
    super.onInit();
  }

  Stream<List<Users>> getAllUser() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Users.fromMap(item)).toList());
  Stream<List<Complaint>> getAllComplaint() =>
      collectionReference2.snapshots().map((query) =>
          query.docs.map((item) => Complaint.fromMap(item)).toList());
  Stream<List<NotificationModel>> getAllNotification() =>
      collectionReference3.snapshots().map((query) =>
          query.docs.map((item) => NotificationModel.fromMap(item)).toList());
  // String? get user_ch => _user.value!.email;
  _initialScreen(User? user) {
    if (user == null) {
      route = const LoginPage();
    } else {
      route = const HomeScreen();
    }
  }

  toggleLogin() {
    obscureTextLogin = !obscureTextLogin;

    update(['loginOb']);
  }

  toggleSignup() {
    obscureTextSignup = !obscureTextSignup;
    update(['reOb']);
  }

  toggleSignupConfirm() {
    obscureTextSignupConfirm = !obscureTextSignupConfirm;
    update(['RreOb']);
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter your name";
    }

    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "please enter your Phone";
    }
    if (value.length < 10) {
      return "Phone length must be more than 10";
    }

    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty) {
      return "please enter your email";
    }

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    if (Rpassword.text != value) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  changeOb() {
    ob = !ob;
    update(['password']);
  }

  void addSets(String id, String noId) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();
    Get.dialog(AlertDialog(
      content: const Text('تعديل الرحلة'),
      actions: [
        Form(
          key: formKey5,
          child: Column(
            children: [
              CustomTextField(
                  controller: controller2,
                  validator: (validator) {
                    if (validator!.isEmpty) {
                      return "please add field";
                    }
                    return null;
                  },
                  lable: 'اضافة رقم الرحلة',
                  icon: const Icon(Icons.numbers),
                  input: TextInputType.number),
            ],
          ),
        ),
        CustomTextField(
            controller: controller,
            validator: (validator) {
              if (validator!.isEmpty) {
                return "please add field";
              }
              return null;
            },
            lable: 'اضافة مقاعد',
            icon: const Icon(Icons.numbers),
            input: TextInputType.number),
        TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty && controller2.text.isNotEmpty) {
                try {
                  showdilog();
                  FirebaseFirestore.instance
                      .collection('Travel')
                      .doc(id)
                      .update({
                    "count": int.tryParse(controller.text),
                    "No": int.tryParse(controller2.text)
                  });
                  FirebaseFirestore.instance
                      .collection('notification')
                      .doc(noId)
                      .delete();
                  Get.back();
                  Get.back();
                  showbar('تعديل الرحلة', '', 'تمت العملية بنجاح!!!', true);
                } catch (e) {
                  showbar('تعديل الرحلة ', '', e.toString(), false);
                  Get.back();
                }
              } else {
                showbar(
                    'تعديل الرحلة', '', 'الرجاء ادخال جميع البيانات', false);
              }
            },
            child: const Text('حفظ')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('رجوع'))
      ],
    ));
  }

  void deleteNotification(String id) {
    Get.dialog(AlertDialog(
      content: const Text('حذف اشعار'),
      actions: [
        TextButton(
            onPressed: () async {
              try {
                showdilog();
                FirebaseFirestore.instance
                    .collection('notification')
                    .doc(id)
                    .delete();
                Get.back();
                Get.back();
                showbar('حذف اشعار', '', 'تم حذف اشعار ', true);
              } catch (e) {
                showbar('حذف اشعار ', '', e.toString(), false);
                Get.back();
              }
            },
            child: const Text('حذف')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('رجوع'))
      ],
    ));
  }

  void deleteCustomer(String id) {
    Get.dialog(AlertDialog(
      content: const Text('حذف عميل'),
      actions: [
        TextButton(
            onPressed: () async {
              try {
                showdilog();
                FirebaseFirestore.instance.collection('users').doc(id).delete();
                Get.back();
                Get.back();
                showbar('حذف عميل', '', 'حذف عميل', true);
              } catch (e) {
                showbar('حذف عميل ', '', e.toString(), false);
                Get.back();
              }
            },
            child: const Text('حذف')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('رجوع'))
      ],
    ));
  }

  void signOut() async {
    Get.dialog(AlertDialog(
      content: const Text('هل تريد تسجيل الخروج من التطبيق'),
      actions: [
        TextButton(
            onPressed: () async {
              await auth
                  .signOut()
                  .then((value) => Get.offAll(() => const LoginPage()));
            },
            child: const Text('تاكيد')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('رجوع'))
      ],
    ));
  }

  void register() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        repassword.text.isNotEmpty) {
      if (password.text == repassword.text) {
        try {
          showdilog();
          final credential = await auth.createUserWithEmailAndPassword(
              email: email.text, password: password.text);
          credential.user!.updateDisplayName(name.text);
          await credential.user!.reload();
          await FirebaseFirestore.instance
              .collection('admin')
              .doc(credential.user!.uid)
              .set({
            'name': name.text,
            'email': email.text,
            'approv': 0,
            'uid': credential.user!.uid,
          });
          email.clear();
          password.clear();
          Get.back();
          showbar("About User", "User message", "تم التسجيل بنجاح!!", true);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            Get.back();
            showbar(
                "About Login", "Login message", 'الايميل محجوز مسبقا', false);
          }
          if (e.code == 'weak-password') {
            Get.back();
            showbar("About Login", "Login message", 'كلمة المرور ضعيفة', false);
          } else {
            Get.back();
            showbar("About User", "User message", e.toString(), false);
          }
        }
      } else {
        showbar(
            "About User", "User message", 'الرجاء مطابقة كلمة المرور', false);
      }
    } else {
      showbar(
          "About User", "User message", 'الرجاء ادخال جميع البيانات', false);
    }
  }

  void login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        showdilog();
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        var ch = await FirebaseFirestore.instance
            .collection('admin')
            // .where('aprrov', isEqualTo: 1)
            // .where('email', isEqualTo: email.text)
            .get();
        int approve = 0;
        for (var element in ch.docs) {
          if (element['approv'] == 1 && element['email'] == email.text) {
            approve = 1;
            // Get.back();
            // Get.offAll(() => const HomeScreen());
          }
        }
        if (approve == 1) {
          email.clear();
          password.clear();
          Get.back();
          Get.offAll(() => const HomeScreen());
        } else {
          Get.back();
          showbar(
              "About Login", "Login message", 'ليس لديك صلاحية للدخول', false);
        }
        // if (ch.docs.isNotEmpty) {
        //   Get.back();
        //   Get.offAll(() => const HomeScreen());
        // } else {

        // }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          showbar("About Login", "Login message", 'كلمة السر ضعيفة', false);
        }
        if (e.code == 'email-already-in-use') {
          Get.back();
          showbar("About Login", "Login message", 'الايميل محجوز مسبقا', false);
        }
        if (e.code == 'user-not-found') {
          Get.back();
          showbar("About Login", "Login message", ' اليوزر غير موجود', false);
        }
        if (e.code == 'wrong-password') {
          Get.back();
          showbar(
              "About Login", "Login message", ' كلمة السر غير صحيحة', false);
        } else {
          Get.back();
          showbar("About Login", "Login message", e.toString(), false);
        }
      }
    } else {
      showbar(
          "About Login", "Login message", 'الرجاء ادخال جميع البيانات', false);
    }
  }
}
