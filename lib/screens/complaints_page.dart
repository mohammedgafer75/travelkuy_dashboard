import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:travelkuy_dashboard/controller/auth_controller.dart';

import '/style/theme.dart' as theme;

class Complaints extends StatelessWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشكاوي'),
      ),
      body: GetX<AuthController>(
        builder: (logic) {
          if (logic.complaints.isEmpty) {
            return const Center(child: Text('لا يوجد شكاوي'));
          } else {
            return ListView.builder(
                itemCount: logic.complaints.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.blueAccent,
                            theme.Colors.loginGradientEnd
                          ],
                          // begin: FractionalOffset(0.0, 0.0),
                          // end: FractionalOffset(1.0, 1.0),
                          // stops: [0.0, 1.0],
                          // tileMode: TileMode.clamp
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'شكوى من:   ${logic.complaints[index].name}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'الايميل:  ${logic.complaints[index].email}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'الشكوى:  ${logic.complaints[index].description}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
