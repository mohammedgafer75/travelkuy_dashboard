import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:travelkuy_dashboard/screens/all_reservtion.dart';
import 'package:travelkuy_dashboard/screens/all_travel.dart';
import 'package:travelkuy_dashboard/screens/change_password.dart';
import 'package:travelkuy_dashboard/screens/complaints_page.dart';
import 'package:travelkuy_dashboard/screens/customer.dart';
import 'package:travelkuy_dashboard/screens/notification.dart';
import 'package:travelkuy_dashboard/screens/resevtion.dart';

import '../controller/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        actions: [
          Obx(() => IconBadge(
                itemCount: controller.not.length,
                icon: const Icon(Icons.notifications),
                onTap: () {
                  Get.to(() => const NotificationPage());
                },
              )),
          IconButton(
              onPressed: () {
                controller.signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
        // backgroundColor: Colors.yellow[800],
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: height / 7,
        ),
        padding: EdgeInsets.only(left: width / 8, right: width / 8),
        child: Center(
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: .90,
              children: const [
                Card_d(
                  icon: Icon(Icons.add_location_alt_outlined,
                      size: 30, color: Colors.white),
                  title: 'اضافة رحلة',
                  nav: Reservtion(),
                ),
                Card_d(
                  icon:
                      Icon(Icons.travel_explore, size: 30, color: Colors.white),
                  title: 'عرض جميع الرحلات',
                  nav: AllTravel(),
                ),
                Card_d(
                  icon: Icon(Icons.check_circle_outline_sharp,
                      size: 30, color: Colors.white),
                  title: 'الحجوزات',
                  nav: AllReservtion(),
                ),
                Card_d(
                  icon: Icon(Icons.supervised_user_circle_sharp,
                      size: 30, color: Colors.white),
                  title: 'المشتركين',
                  nav: Customers(),
                ),
                Card_d(
                  icon: Icon(Icons.supervised_user_circle_sharp,
                      size: 30, color: Colors.white),
                  title: 'الشكاوى',
                  nav: Complaints(),
                ),
                Card_d(
                  icon: Icon(Icons.supervised_user_circle_sharp,
                      size: 30, color: Colors.white),
                  title: 'تغير كلمة السر',
                  nav: ChangePassword(),
                ),
              ]),
        ),
      ),
    );
  }
}

class Card_d extends StatefulWidget {
  const Card_d(
      {Key? key, required this.title, required this.icon, required this.nav})
      : super(key: key);
  final String title;
  final dynamic icon;
  final dynamic nav;

  @override
  State<Card_d> createState() => _Card_dState();
}

// ignore: camel_case_types
class _Card_dState extends State<Card_d> {
  void showBar(BuildContext context, String msg) {
    var bar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.nav));
      },
      child: Card(
        color: Colors.blueAccent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: widget.icon),
              const SizedBox(
                height: 10,
              ),
              Text(widget.title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
